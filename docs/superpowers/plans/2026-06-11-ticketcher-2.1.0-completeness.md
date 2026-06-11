# Ticketcher 2.1.0 API Completeness Batch Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Ship five additive decoration features — multi-shadow, top border pattern, dashed outer border, per-boundary dividers, punch holes — with zero breaking changes, as release 2.1.0.

**Architecture:** Pure Dart/Flutter package. New optional fields on `TicketcherDecoration` / `Section` plus two new value models. Painting changes mirrored in `vticketcher_painter.dart` AND `hticketcher_painter.dart` (project rule). Geometry shared through `TicketPathBuilder`. Every new field participates in `copyWith`/`==`/`hashCode` so the value-based `shouldRepaint` contract from 1.3.x stays correct.

**Tech Stack:** Flutter (SDK ^3.7.0), `flutter_test`, `flutter_lints`. Zero external dependencies — keep it that way.

**Spec:** `docs/superpowers/specs/2026-06-11-ticketcher-2.1.0-completeness-design.md`

**Conventions:**
- Run all commands from repo root.
- Commit attribution: author is `fathialamre`. NEVER add `Co-Authored-By: Claude` or any Claude attribution (project rule in CLAUDE.md).
- `flutter analyze` must stay clean after every task (strict-casts/strict-inference/strict-raw-types are on).

---

### Task 1: `BorderDash` model

**Files:**
- Create: `lib/src/models/border_dash.dart`
- Modify: `lib/ticketcher.dart`
- Create: `test/models/border_dash_test.dart`

- [ ] **Step 1: Write the failing test**

Create `test/models/border_dash_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/ticketcher.dart';

void main() {
  group('BorderDash', () {
    test('equal values ⇒ equal and same hashCode', () {
      const a = BorderDash(dash: 6, gap: 4);
      const b = BorderDash(dash: 6, gap: 4);
      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
    });

    test('differing dash ⇒ unequal', () {
      const a = BorderDash(dash: 6, gap: 4);
      const b = BorderDash(dash: 8, gap: 4);
      expect(a, isNot(equals(b)));
    });

    test('differing gap ⇒ unequal', () {
      const a = BorderDash(dash: 6, gap: 4);
      const b = BorderDash(dash: 6, gap: 5);
      expect(a, isNot(equals(b)));
    });

    test('copyWith replaces only given fields', () {
      const a = BorderDash(dash: 6, gap: 4);
      final b = a.copyWith(gap: 9);
      expect(b.dash, 6);
      expect(b.gap, 9);
      expect(a.copyWith(), equals(a));
    });

    test('non-positive dash or gap asserts', () {
      expect(() => BorderDash(dash: 0, gap: 4), throwsAssertionError);
      expect(() => BorderDash(dash: 6, gap: 0), throwsAssertionError);
      expect(() => BorderDash(dash: -1, gap: 4), throwsAssertionError);
    });
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/models/border_dash_test.dart`
Expected: FAIL — compile error, `BorderDash` undefined.

- [ ] **Step 3: Write the model**

Create `lib/src/models/border_dash.dart`:

```dart
import 'package:flutter/foundation.dart';

/// Defines a dash pattern for the ticket's outer border.
///
/// When set on [TicketcherDecoration.borderDash] together with an active
/// border (`border` or `borderGradient`), the ticket outline is stroked as
/// dashes instead of a solid line. The dashing follows the full outline —
/// corners, notches, and border patterns included.
///
/// Has no effect when neither `border` nor `borderGradient` is set.
///
/// Example:
/// ```dart
/// TicketcherDecoration(
///   border: Border.all(color: Colors.amber, width: 2),
///   borderDash: BorderDash(dash: 7, gap: 5),
/// )
/// ```
@immutable
class BorderDash {
  /// The length of each dash segment in logical pixels. Must be > 0.
  final double dash;

  /// The gap between dash segments in logical pixels. Must be > 0.
  final double gap;

  const BorderDash({required this.dash, required this.gap})
      : assert(dash > 0, 'dash must be greater than 0'),
        assert(gap > 0, 'gap must be greater than 0');

  BorderDash copyWith({double? dash, double? gap}) {
    return BorderDash(dash: dash ?? this.dash, gap: gap ?? this.gap);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BorderDash && other.dash == dash && other.gap == gap;
  }

  @override
  int get hashCode => Object.hash(dash, gap);
}
```

- [ ] **Step 4: Export from the barrel**

In `lib/ticketcher.dart`, the export list is alphabetical. Add after the `blur_effect.dart` line:

```dart
export 'src/models/border_dash.dart';
```

Result (top of file):

```dart
export 'src/models/blur_effect.dart';
export 'src/models/border_dash.dart';
export 'src/models/border_pattern.dart';
```

- [ ] **Step 5: Run test to verify it passes**

Run: `flutter test test/models/border_dash_test.dart`
Expected: PASS (5 tests).

- [ ] **Step 6: Analyze and commit**

```bash
flutter analyze
git add lib/src/models/border_dash.dart lib/ticketcher.dart test/models/border_dash_test.dart
git commit -m "feat: add BorderDash model for dashed outer borders"
```

---

### Task 2: `PunchHole` model

**Files:**
- Create: `lib/src/models/punch_hole.dart`
- Modify: `lib/ticketcher.dart`
- Create: `test/models/punch_hole_test.dart`

- [ ] **Step 1: Write the failing test**

Create `test/models/punch_hole_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/ticketcher.dart';

void main() {
  group('PunchHole', () {
    test('defaults: topCenter alignment, zero offset, semicircle shape', () {
      const hole = PunchHole(radius: 6);
      expect(hole.alignment, Alignment.topCenter);
      expect(hole.offset, Offset.zero);
      expect(hole.shape, NotchShape.semicircle);
    });

    test('equal values ⇒ equal and same hashCode', () {
      const a = PunchHole(
        alignment: Alignment.topCenter,
        offset: Offset(0, 12),
        radius: 6,
      );
      const b = PunchHole(
        alignment: Alignment.topCenter,
        offset: Offset(0, 12),
        radius: 6,
      );
      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
    });

    test('differing radius ⇒ unequal', () {
      const a = PunchHole(radius: 6);
      const b = PunchHole(radius: 7);
      expect(a, isNot(equals(b)));
    });

    test('differing shape ⇒ unequal', () {
      const a = PunchHole(radius: 6);
      const b = PunchHole(radius: 6, shape: NotchShape.diamond);
      expect(a, isNot(equals(b)));
    });

    test('copyWith replaces only given fields', () {
      const a = PunchHole(radius: 6, offset: Offset(2, 3));
      final b = a.copyWith(radius: 9);
      expect(b.radius, 9);
      expect(b.offset, const Offset(2, 3));
      expect(a.copyWith(), equals(a));
    });

    test('non-positive radius asserts', () {
      expect(() => PunchHole(radius: 0), throwsAssertionError);
      expect(() => PunchHole(radius: -2), throwsAssertionError);
    });
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/models/punch_hole_test.dart`
Expected: FAIL — compile error, `PunchHole` undefined.

- [ ] **Step 3: Write the model**

Create `lib/src/models/punch_hole.dart`:

```dart
import 'package:flutter/material.dart';
import 'notch_shape.dart';

/// A hole punched through the ticket shape.
///
/// The hole is a true cutout: background color/gradient/image, shadows,
/// the blur clip, and the border stroke all respect it. With a border set,
/// the stroke automatically draws a ring around the hole.
///
/// Position = [alignment] resolved within the ticket rect, then nudged by
/// [offset] in logical pixels.
///
/// [shape] reuses [NotchShape]; for an interior hole, [NotchShape.semicircle]
/// renders as a full circle. [radius] is the circle radius, or the half-extent
/// for square/diamond/triangle.
///
/// Placement sanity (keeping holes away from notches, dividers, and edges)
/// is the caller's responsibility. A divider line crossing a hole paints
/// over it.
///
/// Example — lanyard hole top center:
/// ```dart
/// TicketcherDecoration(
///   punchHoles: [
///     PunchHole(alignment: Alignment.topCenter, offset: Offset(0, 15), radius: 7),
///   ],
/// )
/// ```
@immutable
class PunchHole {
  /// Where the hole sits within the ticket rectangle.
  final Alignment alignment;

  /// Pixel nudge applied after [alignment] is resolved.
  final Offset offset;

  /// Circle radius / half-extent of the hole. Must be > 0.
  final double radius;

  /// The hole shape. [NotchShape.semicircle] means a full circle here.
  final NotchShape shape;

  const PunchHole({
    this.alignment = Alignment.topCenter,
    this.offset = Offset.zero,
    required this.radius,
    this.shape = NotchShape.semicircle,
  }) : assert(radius > 0, 'radius must be greater than 0');

  PunchHole copyWith({
    Alignment? alignment,
    Offset? offset,
    double? radius,
    NotchShape? shape,
  }) {
    return PunchHole(
      alignment: alignment ?? this.alignment,
      offset: offset ?? this.offset,
      radius: radius ?? this.radius,
      shape: shape ?? this.shape,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PunchHole &&
        other.alignment == alignment &&
        other.offset == offset &&
        other.radius == radius &&
        other.shape == shape;
  }

  @override
  int get hashCode => Object.hash(alignment, offset, radius, shape);
}
```

- [ ] **Step 4: Export from the barrel**

In `lib/ticketcher.dart`, add after the `notch_shape.dart` export:

```dart
export 'src/models/punch_hole.dart';
```

- [ ] **Step 5: Run test to verify it passes**

Run: `flutter test test/models/punch_hole_test.dart`
Expected: PASS (6 tests).

- [ ] **Step 6: Analyze and commit**

```bash
flutter analyze
git add lib/src/models/punch_hole.dart lib/ticketcher.dart test/models/punch_hole_test.dart
git commit -m "feat: add PunchHole model"
```

---

### Task 3: New `TicketcherDecoration` fields

**Files:**
- Modify: `lib/src/models/ticketcher_decoration.dart`
- Modify: `test/models/decoration_equality_test.dart`
- Modify: `test/painters/should_repaint_test.dart`

- [ ] **Step 1: Write the failing tests**

Append inside the existing top-level `group` in `test/models/decoration_equality_test.dart` (add a nested group at the end of `main`'s body; match the file's existing import set — it already imports `package:flutter/material.dart`, `package:flutter_test/flutter_test.dart`, `package:ticketcher/ticketcher.dart`):

```dart
  group('TicketcherDecoration 2.1.0 fields', () {
    test('differing shadows ⇒ unequal', () {
      const a = TicketcherDecoration(
        shadows: [BoxShadow(color: Colors.red, blurRadius: 4)],
      );
      const b = TicketcherDecoration(
        shadows: [BoxShadow(color: Colors.blue, blurRadius: 4)],
      );
      expect(a, isNot(equals(b)));
    });

    test('content-equal shadows lists ⇒ equal', () {
      const a = TicketcherDecoration(
        shadows: [BoxShadow(color: Colors.red, blurRadius: 4)],
      );
      const b = TicketcherDecoration(
        shadows: [BoxShadow(color: Colors.red, blurRadius: 4)],
      );
      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
    });

    test('differing topBorderStyle ⇒ unequal', () {
      const a = TicketcherDecoration(
        topBorderStyle: BorderPattern(shape: BorderShape.sharp),
      );
      const b = TicketcherDecoration();
      expect(a, isNot(equals(b)));
    });

    test('differing borderDash ⇒ unequal', () {
      const a = TicketcherDecoration(borderDash: BorderDash(dash: 6, gap: 4));
      const b = TicketcherDecoration(borderDash: BorderDash(dash: 6, gap: 5));
      expect(a, isNot(equals(b)));
    });

    test('differing punchHoles ⇒ unequal; content-equal ⇒ equal', () {
      const a = TicketcherDecoration(punchHoles: [PunchHole(radius: 6)]);
      const b = TicketcherDecoration(punchHoles: [PunchHole(radius: 7)]);
      const c = TicketcherDecoration(punchHoles: [PunchHole(radius: 6)]);
      expect(a, isNot(equals(b)));
      expect(a, equals(c));
      expect(a.hashCode, c.hashCode);
    });

    test('copyWith round-trips new fields', () {
      const a = TicketcherDecoration(
        shadows: [BoxShadow(color: Colors.red)],
        topBorderStyle: BorderPattern(shape: BorderShape.wave),
        borderDash: BorderDash(dash: 6, gap: 4),
        punchHoles: [PunchHole(radius: 6)],
      );
      expect(a.copyWith(), equals(a));
      expect(
        a.copyWith(borderDash: const BorderDash(dash: 1, gap: 1)).borderDash,
        const BorderDash(dash: 1, gap: 1),
      );
    });
  });
```

Append inside the `VTicketcherPainter.shouldRepaint` group in `test/painters/should_repaint_test.dart`:

```dart
    test('different shadows ⇒ true', () {
      final a = _vp();
      final b = _vp(
        decoration: const TicketcherDecoration(
          shadows: [BoxShadow(color: Colors.red, blurRadius: 4)],
        ),
      );
      expect(b.shouldRepaint(a), isTrue);
    });

    test('different punchHoles ⇒ true', () {
      final a = _vp();
      final b = _vp(
        decoration: const TicketcherDecoration(
          punchHoles: [PunchHole(radius: 6)],
        ),
      );
      expect(b.shouldRepaint(a), isTrue);
    });
```

- [ ] **Step 2: Run tests to verify they fail**

Run: `flutter test test/models/decoration_equality_test.dart test/painters/should_repaint_test.dart`
Expected: FAIL — compile errors, named parameters `shadows`/`topBorderStyle`/`borderDash`/`punchHoles` undefined.

- [ ] **Step 3: Add the fields**

In `lib/src/models/ticketcher_decoration.dart`:

3a. Add imports at the top (after the existing `import 'blur_effect.dart';`):

```dart
import 'border_dash.dart';
import 'punch_hole.dart';
```

3b. Add the four fields to the class, after the existing `final BoxShadow? shadow;` declaration block. Current field list ends with `notchStyle`/background-image fields; insert these with the other visual fields (directly after `final BoxShadow? shadow;` is fine — if `shadow` is declared as part of the long field list, place them right below it):

```dart
  /// Multiple shadows under the ticket, drawn in list order.
  ///
  /// When non-null this takes precedence over the legacy single [shadow].
  /// An explicit empty list disables shadows entirely.
  final List<BoxShadow>? shadows;

  /// Border pattern for the TOP edge (wave, sharp, arc).
  ///
  /// Vertical tickets only — horizontal tickets ignore it (their top edge
  /// carries the section notches). Cannot be combined with a top corner
  /// radius; `VTicketcher` asserts this.
  final BorderPattern? topBorderStyle;

  /// Dash pattern for the outer border stroke.
  ///
  /// Only takes effect when [border] or [borderGradient] is set.
  final BorderDash? borderDash;

  /// Holes punched through the ticket shape.
  ///
  /// Cutouts are honored by background, shadows, blur clipping, and the
  /// border stroke (which rings each hole).
  final List<PunchHole>? punchHoles;
```

3c. Add the four constructor parameters (anywhere in the named-parameter list; keep them together after `this.shadow,`):

```dart
    this.shadows,
    this.topBorderStyle,
    this.borderDash,
    this.punchHoles,
```

3d. Extend `copyWith` — add parameters and forwarding:

```dart
    List<BoxShadow>? shadows,
    BorderPattern? topBorderStyle,
    BorderDash? borderDash,
    List<PunchHole>? punchHoles,
```

and in the returned constructor call:

```dart
      shadows: shadows ?? this.shadows,
      topBorderStyle: topBorderStyle ?? this.topBorderStyle,
      borderDash: borderDash ?? this.borderDash,
      punchHoles: punchHoles ?? this.punchHoles,
```

3e. Extend `operator ==` — add before the closing `;` of the return expression:

```dart
        listEquals(other.shadows, shadows) &&
        other.topBorderStyle == topBorderStyle &&
        other.borderDash == borderDash &&
        listEquals(other.punchHoles, punchHoles);
```

(`listEquals` comes from `package:flutter/foundation.dart`, re-exported by `material.dart` which is already imported. It handles null-vs-null and null-vs-list correctly.)

3f. Extend `hashCode` — add to the `Object.hashAll([...])` list (lists must be element-hashed, a raw `List.hashCode` is identity-based):

```dart
    shadows == null ? null : Object.hashAll(shadows!),
    topBorderStyle,
    borderDash,
    punchHoles == null ? null : Object.hashAll(punchHoles!),
```

- [ ] **Step 4: Run tests to verify they pass**

Run: `flutter test test/models/decoration_equality_test.dart test/painters/should_repaint_test.dart`
Expected: PASS.

- [ ] **Step 5: Analyze, full test run, commit**

```bash
flutter analyze
flutter test
git add lib/src/models/ticketcher_decoration.dart test/models/decoration_equality_test.dart test/painters/should_repaint_test.dart
git commit -m "feat: add shadows, topBorderStyle, borderDash, punchHoles to TicketcherDecoration"
```

---

### Task 4: `Section.dividerAfter` field

**Files:**
- Modify: `lib/src/models/section.dart`
- Modify: `test/models/section_equality_test.dart`

- [ ] **Step 1: Write the failing tests**

Append inside the `Section equality` group in `test/models/section_equality_test.dart`:

```dart
    test('differing dividerAfter ⇒ unequal', () {
      const child = Text('hi');
      final a = Section(
        child: child,
        dividerAfter: TicketDivider.solid(color: Colors.red),
      );
      final b = Section(
        child: child,
        dividerAfter: TicketDivider.solid(color: Colors.blue),
      );
      final c = Section(
        child: child,
        dividerAfter: TicketDivider.solid(color: Colors.red),
      );
      expect(a, isNot(equals(b)));
      expect(a, equals(c));
    });

    test('copyWith carries dividerAfter', () {
      final divider = TicketDivider.dashed(color: Colors.grey);
      final a = Section(child: const Text('hi'), dividerAfter: divider);
      expect(a.copyWith().dividerAfter, divider);
      expect(a.copyWith(), equals(a));
    });
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/models/section_equality_test.dart`
Expected: FAIL — compile error, named parameter `dividerAfter` undefined.

- [ ] **Step 3: Add the field**

In `lib/src/models/section.dart`:

3a. Add import at top:

```dart
import 'ticket_divider.dart';
```

3b. Add field after `final VoidCallback? onTap;`:

```dart
  /// The divider drawn at the boundary AFTER this section (between this
  /// section and the next one). Overrides the decoration-level
  /// `TicketcherDecoration.divider` for that boundary only.
  ///
  /// Ignored on the last section — there is no boundary after it.
  final TicketDivider? dividerAfter;
```

3c. Add constructor parameter after `this.onTap,`:

```dart
    this.dividerAfter,
```

3d. Extend `copyWith` — parameter:

```dart
    TicketDivider? dividerAfter,
```

forwarding:

```dart
      dividerAfter: dividerAfter ?? this.dividerAfter,
```

3e. Extend `operator ==` — add `other.dividerAfter == dividerAfter &&` alongside the other field comparisons.

3f. Extend `hashCode` — add `dividerAfter,` to the `Object.hash(...)` argument list.

- [ ] **Step 4: Run test to verify it passes**

Run: `flutter test test/models/section_equality_test.dart`
Expected: PASS.

- [ ] **Step 5: Analyze, full test run, commit**

```bash
flutter analyze
flutter test
git add lib/src/models/section.dart test/models/section_equality_test.dart
git commit -m "feat: add Section.dividerAfter for per-boundary dividers"
```

---

### Task 5: Multi-shadow painting (both painters) + shadow offset bugfix

The existing single-shadow code has a latent bug in BOTH painters: `Path.shift`
returns a new path, it does not mutate. `shadowPath.shift(offset)` discards the
result, so shadow offsets were never applied. The rewrite fixes this.

**Files:**
- Modify: `lib/src/painters/vticketcher_painter.dart` (shadow block, currently lines ~665-676)
- Modify: `lib/src/painters/hticketcher_painter.dart` (shadow block, currently lines ~746-757)
- Create: `test/widgets/completeness_features_test.dart`

- [ ] **Step 1: Write the failing-ish smoke test**

Create `test/widgets/completeness_features_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/ticketcher.dart';

Future<void> pumpTicket(WidgetTester tester, Widget ticket) async {
  await tester.pumpWidget(
    MaterialApp(home: Scaffold(body: Center(child: ticket))),
  );
  // Second pump lets the post-frame section measurement pass repaint.
  await tester.pump();
}

const _twoSections = <Section>[
  Section(child: Text('A'), padding: EdgeInsets.all(16)),
  Section(child: Text('B'), padding: EdgeInsets.all(16)),
];

void main() {
  testWidgets('multi-shadow ticket paints without errors', (tester) async {
    await pumpTicket(
      tester,
      VTicketcher(
        sections: _twoSections,
        width: 300,
        decoration: const TicketcherDecoration(
          shadows: [
            BoxShadow(color: Colors.indigo, blurRadius: 8, offset: Offset(0, 4)),
            BoxShadow(color: Colors.pink, blurRadius: 16, offset: Offset(0, 10)),
          ],
        ),
      ),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('empty shadows list suppresses legacy shadow without errors',
      (tester) async {
    await pumpTicket(
      tester,
      VTicketcher(
        sections: _twoSections,
        width: 300,
        decoration: const TicketcherDecoration(
          shadow: BoxShadow(color: Colors.black, blurRadius: 8),
          shadows: [],
        ),
      ),
    );
    expect(tester.takeException(), isNull);
  });
}
```

- [ ] **Step 2: Run test — it should already pass (smoke), confirm baseline**

Run: `flutter test test/widgets/completeness_features_test.dart`
Expected: PASS — `shadows` is accepted by the model since Task 3; the painter
just ignores it so far. This test is the regression net for the painter change.

- [ ] **Step 3: Rewrite the V painter shadow block**

In `lib/src/painters/vticketcher_painter.dart`, replace this block (after `path.close();`):

```dart
    // Draw shadow if specified
    if (decoration.shadow != null) {
      final shadow = decoration.shadow!;
      final shadowPath = Path.from(path);
      shadowPath.shift(Offset(shadow.offset.dx, shadow.offset.dy));

      final shadowPaint = _shadowPaint
        ..color = shadow.color
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadow.blurRadius);

      canvas.drawPath(shadowPath, shadowPaint);
    }
```

with:

```dart
    // Draw shadows if specified. `shadows` wins over the legacy single
    // `shadow`; an explicit empty list disables shadows entirely.
    final resolvedShadows = decoration.shadows ??
        (decoration.shadow != null
            ? <BoxShadow>[decoration.shadow!]
            : const <BoxShadow>[]);
    for (final shadow in resolvedShadows) {
      final shadowPath = path.shift(shadow.offset);
      final shadowPaint = _shadowPaint
        ..color = shadow.color
        ..maskFilter = shadow.blurRadius > 0
            ? MaskFilter.blur(BlurStyle.normal, shadow.blurRadius)
            : null;
      canvas.drawPath(shadowPath, shadowPaint);
    }
```

(`path.shift(...)` returns the shifted copy — this is the offset bugfix. The
`maskFilter` is assigned every iteration, so no stale blur bleeds across the
cached `_shadowPaint`.)

- [ ] **Step 4: Mirror in the H painter**

In `lib/src/painters/hticketcher_painter.dart`, replace the identical block
(after its `path.close();`, currently lines ~746-757) with exactly the same
new code as Step 3.

- [ ] **Step 5: Run tests**

Run: `flutter test`
Expected: ALL PASS (including the two new smokes and all 49+ existing tests).

- [ ] **Step 6: Analyze and commit**

```bash
flutter analyze
git add lib/src/painters/vticketcher_painter.dart lib/src/painters/hticketcher_painter.dart test/widgets/completeness_features_test.dart
git commit -m "feat: support multiple shadows; fix shadow offset never being applied"
```

---

### Task 6: Per-boundary dividers (both painters)

**Files:**
- Modify: `lib/src/painters/vticketcher_painter.dart` (divider loop, currently lines ~771-933)
- Modify: `lib/src/painters/hticketcher_painter.dart` (divider loop, currently lines ~856-1017)
- Modify: `test/widgets/completeness_features_test.dart`
- Modify: `test/painters/should_repaint_test.dart`

- [ ] **Step 1: Write the failing tests**

Append to `main()` in `test/widgets/completeness_features_test.dart`:

```dart
  testWidgets('per-boundary dividers paint without errors (V, 3 sections)',
      (tester) async {
    await pumpTicket(
      tester,
      VTicketcher(
        width: 300,
        sections: [
          Section(
            child: const Text('A'),
            padding: const EdgeInsets.all(16),
            dividerAfter: TicketDivider.tearLine(
              color: Colors.grey,
              dashWidth: 5,
              dashSpace: 4,
            ),
          ),
          Section(
            child: const Text('B'),
            padding: const EdgeInsets.all(16),
            dividerAfter: TicketDivider.smoothWave(
              color: Colors.purple,
              waveHeight: 6,
              waveWidth: 10,
            ),
          ),
          const Section(child: Text('C'), padding: EdgeInsets.all(16)),
        ],
      ),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('dividerAfter without decoration divider paints (H)',
      (tester) async {
    await pumpTicket(
      tester,
      HTicketcher(
        sections: [
          Section(
            child: const Text('A'),
            padding: const EdgeInsets.all(16),
            dividerAfter: TicketDivider.dashed(color: Colors.grey),
          ),
          const Section(child: Text('B'), padding: EdgeInsets.all(16)),
        ],
      ),
    );
    expect(tester.takeException(), isNull);
  });
```

Append inside the `VTicketcherPainter.shouldRepaint` group in `test/painters/should_repaint_test.dart`:

```dart
    test('different Section.dividerAfter ⇒ true', () {
      final a = _vp();
      final b = _vp(
        sections: [
          Section(
            child: const Text('A'),
            dividerAfter: TicketDivider.solid(color: Colors.red),
          ),
          const Section(child: Text('B')),
        ],
      );
      expect(b.shouldRepaint(a), isTrue);
    });
```

- [ ] **Step 2: Run tests — smoke tests pass (painter ignores the field so far), shouldRepaint test passes via Section equality. Confirm baseline.**

Run: `flutter test test/widgets/completeness_features_test.dart test/painters/should_repaint_test.dart`
Expected: PASS. (These guard the refactor — the real verification of this task
is behavior preservation plus the new resolution logic.)

- [ ] **Step 3: Extract `_drawDividerAt` in the V painter**

In `lib/src/painters/vticketcher_painter.dart`:

3a. Add this method to `VTicketcherPainter` (place it directly before the
`paint` method). The switch body is MOVED VERBATIM from the existing divider
loop — every identifier (`y`, `startX`, `endX`, `dividerPaint`, `divider`)
keeps its name, so the moved code compiles unchanged:

```dart
  /// Draws one divider at vertical position [y] using [divider]'s style.
  void _drawDividerAt(
    Canvas canvas,
    Size size,
    TicketDivider divider,
    double y,
  ) {
    final effectiveNotchRadius = decoration.notchStyle?.radius ?? notchRadius;
    final startX = effectiveNotchRadius + (divider.padding ?? 0.0);
    final endX = size.width - effectiveNotchRadius - (divider.padding ?? 0.0);

    // Create paint with gradient support
    final dividerPaint = _dividerLinePaint
      ..strokeWidth = divider.thickness ?? 1.0;

    if (divider.gradient != null) {
      dividerPaint.shader = divider.gradient!.createShader(
        Rect.fromLTRB(startX, y - 10, endX, y + 10),
      );
    } else {
      dividerPaint.shader = null;
      dividerPaint.color = divider.color ?? Colors.grey;
    }

    switch (divider.style) {
      // <<< MOVE the entire existing `switch (divider.style)` body here
      // verbatim from the divider loop in paint() — all cases from
      // DividerStyle.solid through DividerStyle.tearLine, unchanged. >>>
    }
  }
```

3b. Replace the entire old block in `paint()`:

```dart
    // Draw dividers between ticket sections
    if (decoration.divider != null) {
      final divider = decoration.divider!;
      ... // loop with inline paint setup and switch
    }
```

with:

```dart
    // Draw dividers between ticket sections. A section's `dividerAfter`
    // overrides the decoration-level divider for that boundary; null means
    // no divider there.
    for (int i = 0; i < sectionHeights.length - 1; i++) {
      final divider = sections[i].dividerAfter ?? decoration.divider;
      if (divider == null) continue;
      _drawDividerAt(canvas, size, divider, cumulativeHeights[i]);
    }
```

Sanity check after the move: `git diff --stat` for the file should show roughly
as many deletions as insertions (the switch moved, not duplicated), and
`flutter analyze` must report no unused variables left in `paint()`.

- [ ] **Step 4: Mirror in the H painter**

In `lib/src/painters/hticketcher_painter.dart`, same extraction with the
horizontal coordinates. Method (the switch body moves VERBATIM from the H
divider loop — identifiers `x`, `startY`, `endY`, `dividerPaint`, `divider`
unchanged; note the H tearLine case calls `_drawTearLineDividerVertical`):

```dart
  /// Draws one divider at horizontal position [x] using [divider]'s style.
  void _drawDividerAt(
    Canvas canvas,
    Size size,
    TicketDivider divider,
    double x,
  ) {
    final effectiveNotchRadius = decoration.notchStyle?.radius ?? notchRadius;
    final startY = effectiveNotchRadius + (divider.padding ?? 0.0);
    final endY = size.height - effectiveNotchRadius - (divider.padding ?? 0.0);

    // Create paint with gradient support
    final dividerPaint = _dividerLinePaint
      ..strokeWidth = divider.thickness ?? 1.0;

    if (divider.gradient != null) {
      dividerPaint.shader = divider.gradient!.createShader(
        Rect.fromLTRB(x - 10, startY, x + 10, endY),
      );
    } else {
      dividerPaint.shader = null;
      dividerPaint.color = divider.color ?? Colors.grey;
    }

    switch (divider.style) {
      // <<< MOVE the entire existing H `switch (divider.style)` body here
      // verbatim — DividerStyle.solid through DividerStyle.tearLine. >>>
    }
  }
```

Loop replacement in H `paint()`:

```dart
    // Draw dividers between ticket sections. A section's `dividerAfter`
    // overrides the decoration-level divider for that boundary; null means
    // no divider there.
    for (int i = 0; i < sectionWidths.length - 1; i++) {
      final divider = sections[i].dividerAfter ?? decoration.divider;
      if (divider == null) continue;
      _drawDividerAt(canvas, size, divider, cumulativeWidths[i]);
    }
```

- [ ] **Step 5: Run the full suite**

Run: `flutter test`
Expected: ALL PASS — behavior preservation for global dividers is covered by
the existing smoke/snapshot tests; the new smokes cover per-boundary.

- [ ] **Step 6: Analyze and commit**

```bash
flutter analyze
git add lib/src/painters/vticketcher_painter.dart lib/src/painters/hticketcher_painter.dart test/widgets/completeness_features_test.dart test/painters/should_repaint_test.dart
git commit -m "feat: per-boundary dividers via Section.dividerAfter"
```

---

### Task 7: Dashed outer border

**Files:**
- Create: `lib/src/painters/path_dasher.dart`
- Create: `test/painters/path_dasher_test.dart`
- Modify: `lib/src/painters/vticketcher_painter.dart` (border block, currently lines ~751-769)
- Modify: `lib/src/painters/hticketcher_painter.dart` (border block, currently lines ~837-854)
- Modify: `test/widgets/completeness_features_test.dart`

- [ ] **Step 1: Write the failing unit test**

Create `test/painters/path_dasher_test.dart`:

```dart
import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/src/painters/path_dasher.dart';
import 'package:ticketcher/ticketcher.dart';

double _totalLength(Path path) {
  double sum = 0;
  for (final metric in path.computeMetrics()) {
    sum += metric.length;
  }
  return sum;
}

void main() {
  group('dashPath', () {
    test('straight line: dashed length = dashes only', () {
      final line = Path()
        ..moveTo(0, 0)
        ..lineTo(100, 0);
      final dashed = dashPath(line, const BorderDash(dash: 6, gap: 4));
      // Segments start at 0,10,20,...,90 → 10 dashes × 6px = 60px.
      expect(_totalLength(dashed), closeTo(60, 0.1));
    });

    test('trailing partial dash is clamped to the path end', () {
      final line = Path()
        ..moveTo(0, 0)
        ..lineTo(13, 0);
      final dashed = dashPath(line, const BorderDash(dash: 6, gap: 4));
      // Dash 1: [0,6]; dash 2 starts at 10, clamped to [10,13] → 6+3 = 9.
      expect(_totalLength(dashed), closeTo(9, 0.1));
    });

    test('closed contour is dashed across its full perimeter', () {
      final square = Path()..addRect(const Rect.fromLTWH(0, 0, 50, 50));
      final dashed = dashPath(square, const BorderDash(dash: 5, gap: 5));
      // Perimeter 200, duty cycle 1/2 → 100px of dashes.
      expect(_totalLength(dashed), closeTo(100, 0.5));
    });

    test('empty path yields empty result', () {
      final dashed = dashPath(Path(), const BorderDash(dash: 5, gap: 5));
      expect(dashed.computeMetrics().isEmpty, isTrue);
    });
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/painters/path_dasher_test.dart`
Expected: FAIL — compile error, `path_dasher.dart` does not exist.

- [ ] **Step 3: Write the helper**

Create `lib/src/painters/path_dasher.dart`:

```dart
import 'dart:ui';
import '../models/border_dash.dart';

/// Converts [source] into a dashed path: [BorderDash.dash]-length segments
/// separated by [BorderDash.gap]-length holes, following every contour
/// (corners, notches, border patterns) of the original.
Path dashPath(Path source, BorderDash spec) {
  final dest = Path();
  for (final metric in source.computeMetrics()) {
    double distance = 0;
    while (distance < metric.length) {
      final end = (distance + spec.dash).clamp(0.0, metric.length);
      dest.addPath(metric.extractPath(distance, end), Offset.zero);
      distance += spec.dash + spec.gap;
    }
  }
  return dest;
}
```

- [ ] **Step 4: Run test to verify it passes**

Run: `flutter test test/painters/path_dasher_test.dart`
Expected: PASS (4 tests).

- [ ] **Step 5: Wire into the V painter**

In `lib/src/painters/vticketcher_painter.dart`:

5a. Add import (with the other relative imports at the top):

```dart
import 'path_dasher.dart';
```

5b. Replace the border block:

```dart
    // Draw border if specified
    if (decoration.border != null || decoration.borderGradient != null) {
      final borderPaint = _borderPaint;

      if (decoration.borderGradient != null) {
        // Use gradient border
        borderPaint.shader = decoration.borderGradient!.createShader(
          Offset.zero & size,
        );
        borderPaint.strokeWidth = decoration.borderWidth;
      } else if (decoration.border != null) {
        // Use solid color border
        borderPaint.shader = null;
        borderPaint.color = decoration.border!.top.color;
        borderPaint.strokeWidth = decoration.border!.top.width;
      }

      canvas.drawPath(path, borderPaint);
    }
```

with:

```dart
    // Draw border if specified
    if (decoration.border != null || decoration.borderGradient != null) {
      final borderPaint = _borderPaint;

      if (decoration.borderGradient != null) {
        // Use gradient border
        borderPaint.shader = decoration.borderGradient!.createShader(
          Offset.zero & size,
        );
        borderPaint.strokeWidth = decoration.borderWidth;
      } else if (decoration.border != null) {
        // Use solid color border
        borderPaint.shader = null;
        borderPaint.color = decoration.border!.top.color;
        borderPaint.strokeWidth = decoration.border!.top.width;
      }

      final strokePath = decoration.borderDash != null
          ? dashPath(path, decoration.borderDash!)
          : path;
      canvas.drawPath(strokePath, borderPaint);
    }
```

- [ ] **Step 6: Mirror in the H painter (and fix its stale-shader bug)**

In `lib/src/painters/hticketcher_painter.dart`: add the same
`import 'path_dasher.dart';` and apply the same border-block change. NOTE the
H painter's solid branch is currently MISSING `borderPaint.shader = null;`
(latent stale-gradient-shader bug when a rebuild switches gradient → solid
border). The final H block must read identically to the V block above,
including the `borderPaint.shader = null;` line in the solid branch.

- [ ] **Step 7: Add the widget smoke test**

Append to `main()` in `test/widgets/completeness_features_test.dart`:

```dart
  testWidgets('dashed gradient border paints without errors', (tester) async {
    await pumpTicket(
      tester,
      VTicketcher(
        sections: _twoSections,
        width: 300,
        decoration: const TicketcherDecoration(
          borderGradient: LinearGradient(colors: [Colors.amber, Colors.red]),
          borderWidth: 2,
          borderDash: BorderDash(dash: 7, gap: 5),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
  });
```

- [ ] **Step 8: Run the full suite**

Run: `flutter test`
Expected: ALL PASS.

- [ ] **Step 9: Analyze and commit**

```bash
flutter analyze
git add lib/src/painters/path_dasher.dart test/painters/path_dasher_test.dart lib/src/painters/vticketcher_painter.dart lib/src/painters/hticketcher_painter.dart test/widgets/completeness_features_test.dart
git commit -m "feat: dashed outer border via BorderDash; fix stale border shader in H painter"
```

---

### Task 8: Top border pattern (vertical only)

The bottom pattern bulges OUTWARD below `size.height` (`size.height + style.height`).
The top pattern mirrors it: bulges above `y = 0` into negative coordinates.
Nothing shifts — notch and divider positions are untouched. Precedent for the
section-fill extension: the H painter already extends the FIRST section for
`leftBorderStyle` (`sectionX -= width; sectionWidth += width`).

**Files:**
- Modify: `lib/src/widgets/vticketcher.dart` (constructor asserts)
- Modify: `lib/src/painters/vticketcher_painter.dart` (top edge in `paint()`, new `_drawTopPattern`, first-section fill)
- Modify: `test/widgets/completeness_features_test.dart`

- [ ] **Step 1: Write the failing assert test**

Append to `main()` in `test/widgets/completeness_features_test.dart`:

```dart
  testWidgets('topBorderStyle with top radius asserts', (tester) async {
    expect(
      () => VTicketcher(
        sections: _twoSections,
        decoration: const TicketcherDecoration(
          topBorderStyle: BorderPattern(shape: BorderShape.sharp),
          borderRadius: TicketRadius(radius: 8, corner: TicketCorner.top),
        ),
      ),
      throwsAssertionError,
    );
  });

  testWidgets('topBorderStyle paints without errors for all three shapes',
      (tester) async {
    for (final shape in [BorderShape.wave, BorderShape.sharp, BorderShape.arc]) {
      await pumpTicket(
        tester,
        VTicketcher(
          sections: _twoSections,
          width: 300,
          decoration: TicketcherDecoration(
            borderRadius: TicketRadius.zero,
            topBorderStyle: BorderPattern(shape: shape, height: 8, width: 20),
          ),
        ),
      );
      expect(tester.takeException(), isNull, reason: 'shape: $shape');
    }
  });
```

- [ ] **Step 2: Run test to verify the assert test fails**

Run: `flutter test test/widgets/completeness_features_test.dart`
Expected: the assert test FAILS (no assert exists yet, constructor succeeds);
the paint test passes trivially (field ignored so far).

- [ ] **Step 3: Add the constructor assert**

In `lib/src/widgets/vticketcher.dart`, inside the constructor body, after the
existing `bottomBorderStyle` assert, add:

```dart
    assert(
      decoration.topBorderStyle == null ||
          (decoration.borderRadius.corner != TicketCorner.top &&
              decoration.borderRadius.corner != TicketCorner.topLeft &&
              decoration.borderRadius.corner != TicketCorner.topRight &&
              decoration.borderRadius.corner != TicketCorner.all),
      'Cannot use topBorderStyle when there is a top border radius',
    );
```

- [ ] **Step 4: Run test — assert test now passes**

Run: `flutter test test/widgets/completeness_features_test.dart`
Expected: PASS.

- [ ] **Step 5: Add `_drawTopPattern` to the V painter**

In `lib/src/painters/vticketcher_painter.dart`, add this method directly
before the `paint` method:

```dart
  /// Draws the top border pattern across the top edge, bulging ABOVE y=0
  /// (mirror of the bottom pattern, which bulges below size.height).
  ///
  /// The path must already be at (0, 0); on return it is at (size.width, 0).
  /// Top corner radii are excluded by the VTicketcher constructor assert.
  void _drawTopPattern(Path path, Size size) {
    final style = decoration.topBorderStyle!;
    final availableWidth = size.width;

    if (style.shape == BorderShape.arc) {
      // Mirror of the bottom arc pattern: alternating arcs and gaps with the
      // leftover space distributed across the gaps.
      final arcWidth = style.height * 2;
      final gapWidth = style.height;
      final numArcs =
          ((availableWidth - gapWidth) / (arcWidth + gapWidth)).floor();
      if (numArcs <= 0) {
        path.lineTo(size.width, 0);
        return;
      }
      final totalPatternWidth = (numArcs * (arcWidth + gapWidth)) + gapWidth;
      final extraSpace = availableWidth - totalPatternWidth;
      final extraGapWidth = extraSpace / (numArcs + 1);

      var currentX = 0.0;
      path.lineTo(currentX + gapWidth + extraGapWidth, 0);
      currentX += gapWidth + extraGapWidth;

      for (int i = 0; i < numArcs; i++) {
        path.arcToPoint(
          Offset(currentX + arcWidth, 0),
          radius: Radius.circular(style.height),
          clockwise: false,
        );
        currentX += arcWidth;
        if (i < numArcs - 1) {
          path.lineTo(currentX + gapWidth + extraGapWidth, 0);
          currentX += gapWidth + extraGapWidth;
        }
      }
      if (currentX < size.width) {
        path.lineTo(size.width, 0);
      }
    } else {
      final numSegments = (availableWidth / style.width).floor();
      if (numSegments <= 0) {
        path.lineTo(size.width, 0);
        return;
      }
      final adjustedWidth = availableWidth / numSegments;
      var currentX = 0.0;

      while (currentX < size.width) {
        final nextX = (currentX + adjustedWidth).clamp(0.0, size.width);
        final midX = (currentX + nextX) / 2;

        switch (style.shape) {
          case BorderShape.wave:
            path.quadraticBezierTo(midX, -style.height, nextX, 0);
            break;
          case BorderShape.sharp:
            path.lineTo(midX, -style.height);
            path.lineTo(nextX, 0);
            break;
          case BorderShape.arc:
            // Handled above
            break;
        }
        currentX = nextX;
      }
    }
  }
```

- [ ] **Step 6: Route the top edge through the pattern in `paint()`**

In the V painter's `paint()`, replace the current opening (moveTo + top edge +
top-right corner):

```dart
    // Start from the top-left corner
    if (shouldRoundCorner(TicketCorner.topLeft)) {
      path.moveTo(radius, 0);
    } else {
      path.moveTo(0, 0);
    }

    // Top edge and top-right corner
    if (shouldRoundCorner(TicketCorner.topRight)) {
      path.lineTo(size.width - radius, 0);
      path.arcToPoint(
        Offset(size.width, radius),
        radius: Radius.circular(radius),
        clockwise: direction == RadiusDirection.inward,
      );
    } else {
      path.lineTo(size.width, 0);
    }
```

with:

```dart
    // Start from the top-left corner and draw the top edge (optionally
    // patterned — pattern excludes top corner radii via constructor assert).
    if (decoration.topBorderStyle != null) {
      path.moveTo(0, 0);
      _drawTopPattern(path, size);
    } else {
      if (shouldRoundCorner(TicketCorner.topLeft)) {
        path.moveTo(radius, 0);
      } else {
        path.moveTo(0, 0);
      }

      if (shouldRoundCorner(TicketCorner.topRight)) {
        path.lineTo(size.width - radius, 0);
        path.arcToPoint(
          Offset(size.width, radius),
          radius: Radius.circular(radius),
          clockwise: direction == RadiusDirection.inward,
        );
      } else {
        path.lineTo(size.width, 0);
      }
    }
```

- [ ] **Step 7: Extend the first section's fill upward**

Still in the V painter's `paint()`, in the section-backgrounds loop, replace:

```dart
    double currentY = 0;
    for (int i = 0; i < sections.length; i++) {
      final section = sections[i];
      var sectionHeight = sectionHeights[i];
      if (i == sections.length - 1 && decoration.bottomBorderStyle != null) {
        sectionHeight += decoration.bottomBorderStyle!.height;
      }

      final sectionRect = Rect.fromLTWH(0, currentY, size.width, sectionHeight);
```

with:

```dart
    double currentY = 0;
    for (int i = 0; i < sections.length; i++) {
      final section = sections[i];
      var sectionHeight = sectionHeights[i];
      var sectionY = currentY;
      if (i == 0 && decoration.topBorderStyle != null) {
        sectionHeight += decoration.topBorderStyle!.height;
        sectionY -= decoration.topBorderStyle!.height;
      }
      if (i == sections.length - 1 && decoration.bottomBorderStyle != null) {
        sectionHeight += decoration.bottomBorderStyle!.height;
      }

      final sectionRect = Rect.fromLTWH(0, sectionY, size.width, sectionHeight);
```

(The rest of the loop body and the trailing `currentY += sectionHeights[i];`
stay unchanged.)

The H painter gets NO changes — `topBorderStyle` is documented as
vertical-only (same precedent as `stackEffect`).

- [ ] **Step 8: Run the full suite**

Run: `flutter test`
Expected: ALL PASS, including the three-shape paint smoke.

- [ ] **Step 9: Analyze and commit**

```bash
flutter analyze
git add lib/src/widgets/vticketcher.dart lib/src/painters/vticketcher_painter.dart test/widgets/completeness_features_test.dart
git commit -m "feat: top border pattern for vertical tickets"
```

---

### Task 9: Punch holes

**Files:**
- Modify: `lib/src/painters/ticket_path_builder.dart` (new static method + both builders)
- Modify: `lib/src/painters/vticketcher_painter.dart` (subtract after `path.close()`, use `outline` downstream)
- Modify: `lib/src/painters/hticketcher_painter.dart` (same)
- Create: `test/painters/punch_hole_path_test.dart`
- Modify: `test/widgets/completeness_features_test.dart`

- [ ] **Step 1: Write the failing geometry test**

Create `test/painters/punch_hole_path_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/src/painters/ticket_path_builder.dart';
import 'package:ticketcher/ticketcher.dart';

void main() {
  group('punch holes in TicketPathBuilder', () {
    const decoration = TicketcherDecoration(
      punchHoles: [
        PunchHole(
          alignment: Alignment.topCenter,
          offset: Offset(0, 50),
          radius: 10,
        ),
      ],
    );

    test('vertical clip path: hole center is outside, rim points correct', () {
      final path = TicketPathBuilder.buildVerticalTicketPath(
        size: const Size(200, 300),
        notchRadius: 10,
        decoration: decoration,
        sectionHeights: const [150, 150],
      );
      // Hole center: topCenter of 200x300 = (100, 0), + (0, 50) = (100, 50).
      expect(path.contains(const Offset(100, 50)), isFalse);
      expect(path.contains(const Offset(100, 56)), isFalse); // inside r=10
      expect(path.contains(const Offset(100, 62)), isTrue); // just past rim
      expect(path.contains(const Offset(100, 100)), isTrue); // ticket body
    });

    test('horizontal clip path: hole cut out too', () {
      final path = TicketPathBuilder.buildHorizontalTicketPath(
        size: const Size(300, 150),
        notchRadius: 10,
        decoration: const TicketcherDecoration(
          punchHoles: [
            PunchHole(
              alignment: Alignment.centerLeft,
              offset: Offset(30, 0),
              radius: 8,
            ),
          ],
        ),
        sectionWidths: const [150, 150],
      );
      // Hole center: centerLeft of 300x150 = (0, 75), + (30, 0) = (30, 75).
      expect(path.contains(const Offset(30, 75)), isFalse);
      expect(path.contains(const Offset(50, 75)), isTrue);
    });

    test('square hole shape cuts a square', () {
      final path = TicketPathBuilder.buildVerticalTicketPath(
        size: const Size(200, 300),
        notchRadius: 10,
        decoration: const TicketcherDecoration(
          punchHoles: [
            PunchHole(
              alignment: Alignment.center,
              radius: 10,
              shape: NotchShape.square,
            ),
          ],
        ),
        sectionHeights: const [150, 150],
      );
      // Center of ticket = (100, 150). Square corner (108, 142) is inside the
      // square hole but OUTSIDE a circle of r=10 — distinguishes the shapes.
      expect(path.contains(const Offset(100, 150)), isFalse);
      expect(path.contains(const Offset(108, 142)), isFalse);
      expect(path.contains(const Offset(100, 165)), isTrue);
    });

    test('no holes ⇒ path unchanged behavior (contains center)', () {
      final path = TicketPathBuilder.buildVerticalTicketPath(
        size: const Size(200, 300),
        notchRadius: 10,
        decoration: const TicketcherDecoration(),
        sectionHeights: const [150, 150],
      );
      expect(path.contains(const Offset(100, 150)), isTrue);
    });
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/painters/punch_hole_path_test.dart`
Expected: FAIL — the hole-center `contains` checks return true (no subtraction
exists yet).

- [ ] **Step 3: Add `subtractPunchHoles` to `TicketPathBuilder`**

In `lib/src/painters/ticket_path_builder.dart`:

3a. Add import:

```dart
import '../models/punch_hole.dart';
```

3b. Add the static method to the `TicketPathBuilder` class:

```dart
  /// Subtracts [holes] from [outline] and returns the combined path.
  ///
  /// Hole centers are resolved as `alignment.withinRect(Offset.zero & size)
  /// + offset`. [NotchShape.semicircle] cuts a full circle; the other shapes
  /// cut a square/diamond/triangle with half-extent `radius`.
  static Path subtractPunchHoles(
    Path outline,
    Size size,
    List<PunchHole> holes,
  ) {
    if (holes.isEmpty) return outline;
    final holesPath = Path();
    for (final hole in holes) {
      final center = hole.alignment.withinRect(Offset.zero & size) + hole.offset;
      final r = hole.radius;
      switch (hole.shape) {
        case NotchShape.semicircle:
          holesPath.addOval(Rect.fromCircle(center: center, radius: r));
          break;
        case NotchShape.square:
          holesPath.addRect(
            Rect.fromCenter(center: center, width: r * 2, height: r * 2),
          );
          break;
        case NotchShape.diamond:
          holesPath.moveTo(center.dx, center.dy - r);
          holesPath.lineTo(center.dx + r, center.dy);
          holesPath.lineTo(center.dx, center.dy + r);
          holesPath.lineTo(center.dx - r, center.dy);
          holesPath.close();
          break;
        case NotchShape.triangle:
          holesPath.moveTo(center.dx, center.dy - r);
          holesPath.lineTo(center.dx + r, center.dy + r);
          holesPath.lineTo(center.dx - r, center.dy + r);
          holesPath.close();
          break;
      }
    }
    return Path.combine(PathOperation.difference, outline, holesPath);
  }
```

3c. In `buildVerticalTicketPath`, replace the ending:

```dart
    // Close the path
    path.close();
    return path;
```

with:

```dart
    // Close the path
    path.close();

    final holes = decoration.punchHoles;
    if (holes == null || holes.isEmpty) return path;
    return subtractPunchHoles(path, size, holes);
```

3d. Apply the identical ending change in `buildHorizontalTicketPath`.

(This automatically covers the clip path used by `BlurWrapper`/clippers AND
both painters' watermark clip, since `_createTicketPath` delegates here.)

- [ ] **Step 4: Run the geometry test**

Run: `flutter test test/painters/punch_hole_path_test.dart`
Expected: PASS (4 tests).

- [ ] **Step 5: Subtract holes from the V painter's outline**

In `lib/src/painters/vticketcher_painter.dart`, in `paint()`, directly after
`path.close();`, insert:

```dart
    // Punch holes: subtract them from the outline so background, shadows,
    // and the border stroke all respect the cutouts.
    final holes = decoration.punchHoles;
    final Path outline = (holes == null || holes.isEmpty)
        ? path
        : TicketPathBuilder.subtractPunchHoles(path, size, holes);
```

Then replace every later use of `path` in `paint()` with `outline` (the
variable `path` is not referenced again after this point when you're done).
The affected sites and their final forms:

5a. Shadow loop (from Task 5):

```dart
    for (final shadow in resolvedShadows) {
      final shadowPath = outline.shift(shadow.offset);
      ...
    }
```

5b. Decoration background image call: `clipPath: outline,`

5c. Gradient background fill: `canvas.drawPath(outline, backgroundPaint);`

5d. Solid background fill: `canvas.drawPath(outline, backgroundPaint);`

5e. Section background image call: `clipPath: outline,`

5f. Section gradient clip: `canvas.clipPath(outline);`

5g. Section color clip: `canvas.clipPath(outline);`

5h. Border stroke (from Task 7):

```dart
      final strokePath = decoration.borderDash != null
          ? dashPath(outline, decoration.borderDash!)
          : outline;
      canvas.drawPath(strokePath, borderPaint);
```

- [ ] **Step 6: Mirror in the H painter**

Same insertion after the H painter's `path.close();` and the same
`path` → `outline` replacement at its mirror sites: shadow loop, decoration
background image `clipPath:`, gradient fill, solid fill, section image
`clipPath:`, both section `canvas.clipPath(...)` calls, border stroke.

- [ ] **Step 7: Add widget smoke tests**

Append to `main()` in `test/widgets/completeness_features_test.dart`:

```dart
  testWidgets('punch holes paint without errors (V and H)', (tester) async {
    const holeDecoration = TicketcherDecoration(
      border: Border.fromBorderSide(BorderSide(color: Colors.purple)),
      punchHoles: [
        PunchHole(alignment: Alignment.topCenter, offset: Offset(0, 15), radius: 7),
        PunchHole(
          alignment: Alignment.bottomRight,
          offset: Offset(-20, -20),
          radius: 6,
          shape: NotchShape.diamond,
        ),
      ],
    );
    await pumpTicket(
      tester,
      VTicketcher(
        sections: _twoSections,
        width: 300,
        decoration: holeDecoration,
      ),
    );
    expect(tester.takeException(), isNull);

    await pumpTicket(
      tester,
      HTicketcher(sections: _twoSections, decoration: holeDecoration),
    );
    expect(tester.takeException(), isNull);
  });
```

- [ ] **Step 8: Run the full suite**

Run: `flutter test`
Expected: ALL PASS.

- [ ] **Step 9: Analyze and commit**

```bash
flutter analyze
git add lib/src/painters/ticket_path_builder.dart lib/src/painters/vticketcher_painter.dart lib/src/painters/hticketcher_painter.dart test/painters/punch_hole_path_test.dart test/widgets/completeness_features_test.dart
git commit -m "feat: punch holes cut through ticket shape, clip, shadows, and border"
```

---

### Task 10: Example app showcase page

**Files:**
- Create: `example/lib/show_cases/completeness_showcase.dart`
- Modify: `example/lib/main.dart`

- [ ] **Step 1: Create the showcase page**

Create `example/lib/show_cases/completeness_showcase.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

/// Showcases the five 2.1.0 features: multi-shadow, top border pattern,
/// dashed outer border, per-boundary dividers, punch holes.
class CompletenessShowcase extends StatelessWidget {
  const CompletenessShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('2.1.0 Features')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _label('Multi-shadow — layered colored glow'),
            Ticketcher(
              sections: _sections('Concert Pass', 'ROW 4 · SEAT 12'),
              decoration: const TicketcherDecoration(
                shadows: [
                  BoxShadow(
                    color: Color(0x806366F1),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                  BoxShadow(
                    color: Color(0x59EC4899),
                    blurRadius: 18,
                    offset: Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Color(0x330F172A),
                    blurRadius: 36,
                    offset: Offset(0, 22),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            _label('Top border pattern — receipt-style torn edge'),
            Ticketcher(
              sections: _sections('Store Receipt', 'TOTAL \$42.00'),
              decoration: const TicketcherDecoration(
                borderRadius: TicketRadius.zero,
                topBorderStyle: BorderPattern(
                  shape: BorderShape.sharp,
                  height: 8,
                  width: 20,
                ),
                shadow: BoxShadow(
                  color: Colors.black26,
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ),
            ),
            const SizedBox(height: 40),
            _label('Dashed gradient border — coupon cut line'),
            Ticketcher(
              sections: _sections('25% OFF', 'CODE: TKT-25-OFF'),
              decoration: const TicketcherDecoration(
                backgroundColor: Color(0xFFFFFBEB),
                borderGradient: LinearGradient(
                  colors: [Color(0xFFF59E0B), Color(0xFFEF4444)],
                ),
                borderWidth: 2,
                borderDash: BorderDash(dash: 7, gap: 5),
              ),
            ),
            const SizedBox(height: 40),
            _label('Per-boundary dividers — tear line then wave'),
            Ticketcher(
              sections: [
                Section(
                  padding: const EdgeInsets.all(20),
                  dividerAfter: TicketDivider.tearLine(
                    color: Colors.grey,
                    dashWidth: 5,
                    dashSpace: 4,
                    scissorsPosition: ScissorsPosition.start,
                  ),
                  child: const Text(
                    'Boarding Pass',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Section(
                  padding: const EdgeInsets.all(20),
                  dividerAfter: TicketDivider.smoothWave(
                    color: Colors.deepPurple,
                    waveHeight: 6,
                    waveWidth: 10,
                  ),
                  child: const Text('Gate B12 · Boarding 18:40'),
                ),
                const Section(
                  padding: EdgeInsets.all(20),
                  child: Text('Keep this stub'),
                ),
              ],
              decoration: const TicketcherDecoration(
                shadow: BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ),
            ),
            const SizedBox(height: 40),
            _label('Punch hole — lanyard-ready cutout'),
            Ticketcher(
              sections: _sections('VIP BACKSTAGE', 'ALL ACCESS'),
              decoration: const TicketcherDecoration(
                border: Border.fromBorderSide(
                  BorderSide(color: Color(0xFFD946EF), width: 1.5),
                ),
                punchHoles: [
                  PunchHole(
                    alignment: Alignment.topCenter,
                    offset: Offset(0, 15),
                    radius: 7,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  List<Section> _sections(String title, String subtitle) {
    return [
      Section(
        padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      Section(
        padding: const EdgeInsets.all(20),
        child: Text(subtitle, style: const TextStyle(letterSpacing: 1.5)),
      ),
    ];
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, color: Colors.grey),
      ),
    );
  }
}
```

NOTE: `Ticketcher(...)` here is the vertical factory widget from the package
barrel; it forwards `sections`/`decoration` to `VTicketcher`. If its parameter
list differs (check `lib/src/widgets/ticketcher.dart`), use `VTicketcher`
directly with the same arguments.

- [ ] **Step 2: Register in the example home grid**

In `example/lib/main.dart`:

2a. Add import (alphabetical, after `colored_ticket.dart`):

```dart
import 'package:example/show_cases/completeness_showcase.dart';
```

2b. Add as the FIRST entry of the `examples` list (it's the newest feature
set), before the `Notch Shapes` item:

```dart
  // New Features v2.1.0
  ExampleItem(
    icon: Icons.new_releases_outlined,
    title: '2.1.0 Features',
    subtitle: 'Shadows, dashes, holes & more',
    page: const CompletenessShowcase(),
  ),
```

- [ ] **Step 3: Verify the example compiles**

```bash
cd example && flutter pub get && flutter analyze && cd ..
```

Expected: no issues. (Full visual check happens in the release task.)

- [ ] **Step 4: Commit**

```bash
git add example/lib/show_cases/completeness_showcase.dart example/lib/main.dart
git commit -m "docs: add 2.1.0 completeness showcase to example app"
```

---

### Task 11: Docs, changelog, version bump, final verification

**Files:**
- Modify: `pubspec.yaml`
- Modify: `CHANGELOG.md`
- Modify: `README.md`
- Modify: `CLAUDE.md`

- [ ] **Step 1: Bump the version**

In `pubspec.yaml`, change:

```yaml
version: 2.0.0
```

to:

```yaml
version: 2.1.0
```

- [ ] **Step 2: Add the changelog entry**

At the top of `CHANGELOG.md`, before the `## 2.0.0` heading, insert:

```markdown
## 2.1.0

### New features
* **Multiple shadows** — `TicketcherDecoration.shadows: List<BoxShadow>` draws layered shadows in list order. Takes precedence over the legacy single `shadow`; an explicit empty list disables shadows.
* **Top border pattern** — `TicketcherDecoration.topBorderStyle: BorderPattern` mirrors `bottomBorderStyle` on the top edge (wave/sharp/arc). Vertical tickets only; cannot combine with a top corner radius (asserted).
* **Dashed outer border** — `TicketcherDecoration.borderDash: BorderDash(dash:, gap:)` strokes the outline as dashes, following corners, notches, and border patterns. Works with both solid `border` and `borderGradient`.
* **Per-boundary dividers** — `Section.dividerAfter: TicketDivider` styles the boundary after that section, overriding the decoration-level `divider`. Mix tear lines, waves, and dashes in one ticket.
* **Punch holes** — `TicketcherDecoration.punchHoles: List<PunchHole>` cuts true holes through the ticket (background, shadows, blur clip, and border stroke all respect them). Position by `alignment` + `offset`; shapes: circle, square, diamond, triangle.

### Bug fixes
* Shadow `offset` was never applied: both painters called `Path.shift` (which returns a new path) and discarded the result. Offsets now work for `shadow` and `shadows`.
* `HTicketcherPainter` did not reset the border paint's shader when switching from a gradient border to a solid border, leaving a stale gradient.

### Other
* Extracted divider drawing into `_drawDividerAt` in both painters (pure refactor enabling per-boundary dividers).
* New shared geometry: `TicketPathBuilder.subtractPunchHoles`, `dashPath` helper. No new dependencies.
```

- [ ] **Step 3: Update the README**

In `README.md`:

3a. Find the Features list (`grep -n "## Features" README.md`) and add five bullets matching its existing style:

```markdown
- 🌑 **Multiple Shadows**: Layer several `BoxShadow`s for colored glow effects
- 🧾 **Top Border Pattern**: Receipt-style torn top edge (wave, sharp, arc)
- ✂️ **Dashed Outer Border**: Classic coupon cut-line that follows notches and corners
- 🪄 **Per-Boundary Dividers**: A different divider style at every section boundary
- 🕳️ **Punch Holes**: True cutouts for lanyards and tags
```

3b. Add a usage section after the existing divider/border documentation sections (adapt heading level to neighbors):

````markdown
## 2.1.0 Features

### Multiple Shadows

```dart
Ticketcher(
  sections: [...],
  decoration: TicketcherDecoration(
    shadows: [
      BoxShadow(color: Colors.indigo.withOpacity(0.5), blurRadius: 6, offset: Offset(0, 3)),
      BoxShadow(color: Colors.pink.withOpacity(0.35), blurRadius: 18, offset: Offset(0, 10)),
    ],
  ),
)
```

`shadows` wins over the legacy `shadow` when both are set; `shadows: []` disables shadows.

### Top Border Pattern (vertical only)

```dart
TicketcherDecoration(
  borderRadius: TicketRadius.zero, // no top radius with a top pattern
  topBorderStyle: BorderPattern(shape: BorderShape.sharp, height: 8, width: 20),
)
```

### Dashed Outer Border

```dart
TicketcherDecoration(
  borderGradient: LinearGradient(colors: [Colors.amber, Colors.red]),
  borderWidth: 2,
  borderDash: BorderDash(dash: 7, gap: 5),
)
```

Requires `border` or `borderGradient`. The dashes follow the full ticket outline.

### Per-Boundary Dividers

```dart
Ticketcher(
  sections: [
    Section(child: header, dividerAfter: TicketDivider.tearLine(color: Colors.grey)),
    Section(child: body, dividerAfter: TicketDivider.smoothWave(color: Colors.purple)),
    Section(child: stub), // last section: no boundary after it
  ],
)
```

`Section.dividerAfter` overrides the decoration-level `divider` for that boundary only.

### Punch Holes

```dart
TicketcherDecoration(
  punchHoles: [
    PunchHole(alignment: Alignment.topCenter, offset: Offset(0, 15), radius: 7),
  ],
)
```

Holes are true cutouts — background, shadows, blur, and the border stroke all respect them.
````

- [ ] **Step 4: Update CLAUDE.md**

In `CLAUDE.md`, "Adding features — where to touch" list, add:

```markdown
- Dash/outline work: `lib/src/painters/path_dasher.dart` (`dashPath`).
- Punch holes: `PunchHole` model + `TicketPathBuilder.subtractPunchHoles`; subtraction must be applied in BOTH the path builder (clip) and both painters (paint outline).
- Per-boundary dividers: resolution is `sections[i].dividerAfter ?? decoration.divider` inside both painters' divider loops (`_drawDividerAt`).
```

And in the "Invariants enforced by assertions" section, add:

```markdown
- Vertical mode: `topBorderStyle` cannot combine with any top corner radius (top/topLeft/topRight/all) — mirror of the bottom rule. `topBorderStyle` is vertical-only; ignored on horizontal.
- `shadows` takes precedence over legacy `shadow`; an empty `shadows` list disables shadows.
```

- [ ] **Step 5: Final verification**

```bash
flutter analyze
flutter test
cd example && flutter analyze && cd ..
```

Expected: zero analyzer issues, all tests pass.

Optionally launch the example app for a visual pass over the new showcase page:

```bash
cd example && flutter run
```

- [ ] **Step 6: Commit the release**

```bash
git add pubspec.yaml CHANGELOG.md README.md CLAUDE.md
git commit -m "chore: release 2.1.0 — multi-shadow, top border, dashed border, per-boundary dividers, punch holes"
```

---

## Acceptance checklist (maps to spec)

- [ ] `shadows` list painted in order; `shadows` > `shadow`; `[]` disables — Task 3 + 5
- [ ] Shadow offset bug fixed in both painters — Task 5
- [ ] `topBorderStyle` wave/sharp/arc on V top edge; assert vs top radius; H ignores — Task 8
- [ ] `borderDash` dashes solid AND gradient borders, follows full outline; no-op without border — Task 7
- [ ] `Section.dividerAfter` overrides global divider per boundary; last section ignored; null boundary = no divider — Task 4 + 6
- [ ] `punchHoles` cut clip path AND painted outline (background/shadow/border/blur all respect) on V and H — Task 9
- [ ] All new fields in `copyWith`/`==`/`hashCode`; `shouldRepaint` reacts — Tasks 1-4
- [ ] Zero breaking changes, zero new dependencies — all tasks
- [ ] Example page, README, CHANGELOG, version bump, CLAUDE.md — Tasks 10-11
