# Ticketcher 2.1.0 — API Completeness Batch — Design

**Date:** 2026-06-11
**Status:** Approved (visual mockups reviewed in brainstorming session)
**Release:** 2.1.0, purely additive — zero breaking changes on top of 2.0.0

## Goal

Round out the existing decoration API with five small, high-value features that users
of ticket/coupon UIs expect but currently cannot express: multiple shadows, a patterned
top edge, a dashed outer border, per-boundary divider styles, and punch holes.

Strategy is **purely additive** (option A from brainstorming): new optional fields and
models only. The legacy fields keep working unchanged. No deprecations. Model
restructuring (unified `TicketBorder`, edge-style object, divider list) is explicitly
deferred to a future 3.0 if pressure appears.

## Out of scope (this release)

- Tear-off gesture, holographic foil (differentiator track — next releases)
- Capture-to-image, presets/theme, skeleton loading (practical-utility track)
- RTL / Semantics audit (own pass later)
- QR/barcode helpers (would break zero-dependency policy; will be README recipe instead)
- Any breaking model changes

## Feature 1 — Multi-shadow

### API

```dart
TicketcherDecoration(
  shadows: [
    BoxShadow(color: indigo, blurRadius: 5, offset: Offset(0, 3)),
    BoxShadow(color: pink, blurRadius: 18, offset: Offset(0, 10)),
  ],
)
```

- New field: `List<BoxShadow>? shadows` on `TicketcherDecoration`.
- Resolution: `shadows` wins when non-null; else legacy single `shadow`; else none.
  Empty list means "no shadow" (does not fall back to `shadow`).
- `shadow` remains, undeprecated. Its doc comment points to `shadows`.

### Implementation

- Both painters: replace the single shadow draw with a loop over the resolved list,
  reusing the cached `_shadowPaint`, mutating per entry (color, maskFilter from
  `blurRadius`/`spreadRadius`, offset translation) — same pattern as current code.
- Shadow path = ticket outline path (after punch-hole subtraction, see Feature 5).
- `copyWith`, `==`, `hashCode` extended; list compared with `listEquals`
  (helpers in `lib/src/painters/_equality.dart` if reuse fits).

### Edge cases

- `shadows: []` → no shadow drawn even if `shadow` set (explicit override).
- Both `shadows` and `shadow` set → `shadows` wins, documented.

## Feature 2 — Top border pattern

### API

```dart
TicketcherDecoration(
  topBorderStyle: BorderPattern(shape: BorderShape.sharp, height: 8, width: 20),
)
```

- New field: `BorderPattern? topBorderStyle` on `TicketcherDecoration`.
- Reuses existing `BorderPattern` / `BorderShape` (wave, sharp, arc) unchanged.

### Behavior and constraints

- **Vertical tickets only.** Horizontal tickets ignore it (same precedent as
  `stackEffect`); the top edge of a horizontal ticket carries section notches and
  cannot also carry a pattern. Documented on the field.
- New assert in `VTicketcher` mirroring the existing bottom one
  (`lib/src/widgets/vticketcher.dart:92`): `topBorderStyle` cannot combine with a
  top corner radius (`top`/`topLeft`/`topRight`/`all`). Patterns assume straight edges.

### Implementation

- `VTicketcherPainter`: inverse of the existing bottom-pattern logic
  (`vticketcher_painter.dart:542` pattern drawing, `:711` last-section height
  adjustment):
  - `topInset = topBorderStyle?.height ?? 0`.
  - Outline path starts at `y = topInset` and the patterned edge is drawn across the
    top between `y = 0` and `y = topInset` (sharp/wave/arc, same generators as bottom,
    vertically mirrored).
  - First section's painted region extends by the inset exactly as the painter
    extends the last section's region for the bottom pattern
    (`vticketcher_painter.dart:711`), mirrored; notch Y positions and divider
    Y positions shift down by `topInset`.
- Clipper (`TicketPathBuilder.buildVerticalTicketPath`): keeps the straight top edge —
  identical to how the bottom pattern is handled for clipping today (content is
  clipped to the bounding outline; the pattern lives in the painter).

### Edge cases

- `topBorderStyle` + `bottomBorderStyle` together: both insets applied, sections
  between them. No interaction.
- Horizontal ticket: silently ignored, doc note (matches `stackEffect` behavior).

## Feature 3 — Dashed outer border

### API

```dart
TicketcherDecoration(
  border: Border.all(color: amber, width: 2),       // or borderGradient
  borderDash: BorderDash(dash: 7, gap: 5),
)
```

- New model file `lib/src/models/border_dash.dart`:

```dart
@immutable
class BorderDash {
  final double dash;   // > 0
  final double gap;    // > 0
  const BorderDash({required this.dash, required this.gap})
      : assert(dash > 0), assert(gap > 0);
  // copyWith, ==, hashCode
}
```

- New field: `BorderDash? borderDash` on `TicketcherDecoration`.

### Behavior

- When `borderDash` is set and a border is active (`border` or `borderGradient`),
  the outline is stroked dashed instead of solid.
- Applies to the full outline: corners, notches, and border patterns — automatic,
  because dashing operates on the final path.
- `borderDash` with no `border`/`borderGradient` → no-op (nothing to stroke), documented.

### Implementation

- Both painters, at the existing border-stroke site (`vticketcher_painter.dart:752`
  and the H mirror): if `borderDash != null`, transform the outline path through a
  shared helper before stroking:

```dart
// lib/src/painters/path_dasher.dart
Path dashPath(Path source, BorderDash dashSpec)
```

- Helper walks `source.computeMetrics()`, `extractPath(start, start + dash)` stepping
  `dash + gap`, accumulating into one path. Pure Flutter, zero deps.
- Existing paint setup unchanged: gradient shader or solid color applies to the dashed
  path exactly as to the solid one.
- Built inside `paint()` like the outline itself; `shouldRepaint` already value-compares
  the decoration so no extra caching is needed for correctness. (If profiling later
  shows cost, cache keyed on size + decoration — not in this release.)

## Feature 4 — Per-boundary dividers

### API

```dart
Ticketcher(
  sections: [
    Section(child: a, dividerAfter: TicketDivider.tearLine(...)),  // boundary 0
    Section(child: b, dividerAfter: TicketDivider.smoothWave(...)),// boundary 1
    Section(child: c),                                             // last — no boundary
  ],
  decoration: TicketcherDecoration(divider: TicketDivider.dashed(...)), // fallback
)
```

- New field: `TicketDivider? dividerAfter` on `Section`.
- Resolution per boundary `i` (between sections `i` and `i+1`):
  `sections[i].dividerAfter ?? decoration.divider`. Null result → no divider drawn there.
- `dividerAfter` on the last section is ignored (no boundary after it), documented —
  no assert, consistent with how `stackEffect` is leniently ignored on horizontal.

### Implementation

- Both painters: the current divider code is one large `switch (divider.style)` inside
  the boundary loop driven by the single `decoration.divider`
  (`vticketcher_painter.dart:772`). Extract that switch into a private method:

```dart
void _drawDivider(Canvas canvas, Size size, TicketDivider divider, double position)
```

  (position = y for vertical, x for horizontal), then loop boundaries resolving the
  effective divider per index. Pure refactor + per-index resolution; drawing logic
  itself is untouched.
- `Section.copyWith`, `==`, `hashCode` extended. `TicketDivider` equality already
  exists (1.3.0), so `shouldRepaint`/`sectionsEqual` stay correct via the existing
  `sectionsEqual` helper once the new field is included in `Section.==`.

## Feature 5 — Punch hole

### API

```dart
TicketcherDecoration(
  punchHoles: [
    PunchHole(
      alignment: Alignment.topCenter,
      offset: Offset(0, 15),
      radius: 7,
      shape: NotchShape.semicircle,   // reuses existing enum; semicircle = circle
    ),
  ],
)
```

- New model file `lib/src/models/punch_hole.dart`:

```dart
@immutable
class PunchHole {
  final Alignment alignment;       // position within ticket rect
  final Offset offset;             // pixel nudge from the aligned point
  final double radius;             // > 0; circle radius / half-extent for other shapes
  final NotchShape shape;          // semicircle (full circle), square, diamond, triangle
  const PunchHole({
    this.alignment = Alignment.topCenter,
    this.offset = Offset.zero,
    required this.radius,
    this.shape = NotchShape.semicircle,
  }) : assert(radius > 0);
  // copyWith, ==, hashCode
}
```

- New field: `List<PunchHole>? punchHoles` on `TicketcherDecoration`.
- Hole center = `alignment.withinRect(Offset.zero & size) + offset`.
- `NotchShape.semicircle` renders as a full circle when used for a hole (the enum
  names the family; for an interior hole the semicircle generalizes to a circle).
  `square` → square, `diamond` → diamond, `triangle` → triangle, each sized by `radius`.

### Implementation

- Shared geometry helper on `TicketPathBuilder`:

```dart
static Path subtractPunchHoles(Path outline, Size size, List<PunchHole> holes)
```

  Builds each hole path, merges, returns
  `Path.combine(PathOperation.difference, outline, holesPath)`.
- Applied in **both** path consumers:
  - `TicketPathBuilder.buildVerticalTicketPath` / `buildHorizontalTicketPath`
    (clip path) — so child content, background images, gradients and blur are cut out.
  - Both painters' outline construction — so background fill, shadows
    (light shows through the hole), and border stroke all respect the hole.
    Stroking the combined path automatically draws the border ring around each hole.
- Works on both orientations.

### Edge cases

- Hole overlapping the outer edge or a notch: `Path.combine` clips naturally —
  the visible result is the geometric difference. Positioning sanity is the caller's
  responsibility, documented.
- Hole under a divider line: divider draws over the hole (dividers are painted after
  fill); documented as known cosmetic limitation — place holes away from boundaries.
- Empty list / null → no-op.

## Cross-cutting

### Files

| Change | Files |
|---|---|
| New models | `lib/src/models/border_dash.dart`, `lib/src/models/punch_hole.dart` |
| Barrel exports | `lib/ticketcher.dart` (+2 exports) |
| Decoration fields | `lib/src/models/ticketcher_decoration.dart` (`shadows`, `topBorderStyle`, `borderDash`, `punchHoles`) |
| Section field | `lib/src/models/section.dart` (`dividerAfter`) |
| Geometry | `lib/src/painters/ticket_path_builder.dart` (`subtractPunchHoles`), new `lib/src/painters/path_dasher.dart` |
| Painters | `lib/src/painters/vticketcher_painter.dart` + `hticketcher_painter.dart` — every feature mirrored in both (project rule) |
| Widget asserts | `lib/src/widgets/vticketcher.dart` (top-radius assert) |

### Invariants preserved

- All new fields participate in `copyWith`, `==`, `hashCode` → `shouldRepaint`
  value-comparison stays correct (the 1.3.x repaint-correctness work is the contract).
- Background precedence order is untouched.
- Zero new dependencies.

### Testing

Extends the existing scaffolding (`test/models/`, `test/painters/`, `test/widgets/`):

- **Models:** equality/hashCode/copyWith for `BorderDash`, `PunchHole`, and the
  extended `TicketcherDecoration` / `Section` fields.
- **shouldRepaint:** changing each new field triggers repaint; equal values do not.
- **Behavior:**
  - Divider resolution: `dividerAfter` overrides global, falls back when null,
    last-section value ignored.
  - Punch hole: combined path `contains()` is false at hole center, true beside it;
    clip path and painter path agree.
  - Dash helper: dashed path total length ≈ source length × dash/(dash+gap) within
    tolerance; empty for degenerate input.
  - Shadows: `shadows: []` suppresses legacy `shadow`; resolution order verified.
  - Top pattern: assert fires on top radius combos; section offsets shift by inset.

### Example app

One new showcase page `example/lib/show_cases/completeness_showcase.dart`
demonstrating all five features (one ticket each), registered on the example home list.

### Docs / release

- README: five short sections with code snippets (multi-shadow, top border, dashed
  border, per-boundary dividers, punch hole).
- CHANGELOG `2.1.0` entry, `pubspec.yaml` version bump to `2.1.0`.
- CLAUDE.md architecture notes updated: punch holes + dash helper in the
  "Adding features — where to touch" list; background precedence unaffected.

## Implementation order

1. Models + decoration/section fields + exports (pure data, tests first)
2. Multi-shadow (smallest painter change)
3. Per-boundary dividers (refactor switch → `_drawDivider`, then resolution)
4. Dashed border (`path_dasher.dart` + stroke site)
5. Top border pattern (most painter-internal surgery)
6. Punch hole (geometry helper + both path consumers)
7. Example page, README, CHANGELOG, version bump

Each step lands with its tests; `flutter analyze` + `flutter test` green throughout.
