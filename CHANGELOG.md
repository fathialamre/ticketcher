## 1.3.1

### Breaking changes
* **Removed** `AnimatedTicketcher`, `AnimatedTicketcherController`, `TicketAnimation`, and `AnimationType`. The animation layer was a thin wrapper over Flutter's built-in `FadeTransition` / `SlideTransition` / `ScaleTransition` / `Transform` and added more surface area than value. Wrap a `Ticketcher` / `VTicketcher` / `HTicketcher` in those transitions directly if you need entry/exit effects.

### Bug fixes
* Fixed dividers and notches drawing at the top of the ticket (y=0) instead of between sections — reproducible whenever a parent re-render or animation raced the first paint. Root cause: `VTicketcherPainter` / `HTicketcherPainter` / `VTicketcherClipper` / `HTicketcherClipper` stored the per-section size list **by reference** to the State's mutable list. The State measures each section in a `WidgetsBinding.instance.addPostFrameCallback` and mutates that list in place, so the new painter and the OLD painter both pointed at the same (already-mutated) list. `shouldRepaint(oldDelegate)` then compared two equal lists and returned false, leaving the very first paint — the one made before measurement, with all-zero heights — cached forever inside the new `RepaintBoundary` from 1.3.0. Painter / clipper constructors now snapshot the list with `List<double>.unmodifiable(...)`.

## 1.3.0

### Behavior changes
* `Section.==` and `hashCode` now include the `child` widget. Previously two `Section`s with different children but identical decoration compared as equal, which caused the painter's `shouldRepaint` to incorrectly skip repaints when children changed (visual stale-paint bug). If you previously relied on the old behavior, see [migration notes](https://github.com/fathialamre/ticketcher).
* `TicketWatermark.==` and `hashCode` similarly now include the `widget` field for widget watermarks.

### Bug fixes
* `VTicketcherPainter.shouldRepaint` / `HTicketcherPainter.shouldRepaint` now compare `sectionHeights` / `sectionWidths` lists by value (with a 0.5 px epsilon), not by reference. Previously every widget rebuild allocated a new list instance and `oldDelegate.list != newDelegate.list` was always `true`, so the ticket repainted on every parent rebuild even when nothing visual had changed.
* Added `==` and `hashCode` implementations for `BaseDividerStyle` and all 8 divider style subclasses (`SolidDividerStyle`, `DashedDividerStyle`, `CirclesDividerStyle`, `WaveDividerStyle`, `SmoothWaveDividerStyle`, `DottedDividerStyle`, `DoubleLineDividerStyle`, `TearLineDividerStyle`) and the `TicketDivider` wrapper. Previously these fell back to reference equality, causing `TicketcherDecoration.==` to always return false for semantically equal decorations and forcing unnecessary repaints.
* Added `==` and `hashCode` to `TicketWatermark`.
* `ImageResolver.dispose()` and `clear()` now detach pending stream listeners before clearing the internal map. Previously listeners attached during in-flight image loads remained on their `ImageStream` after the resolver was disposed, leaking and risking `setState`-after-`dispose` warnings.
* `_VTicketcherState` / `_HTicketcherState` now route the "decoration image was removed" path through a `mounted`-guarded `setState` instead of mutating `_decorationBackgroundImage` directly. Prevents a missed rebuild when an image is later cleared without changing the section count.

### Performance
* Both painters now cache their `Paint` objects (`_borderPaint`, `_backgroundPaint`, `_dividerLinePaint`, `_dividerFillPaint`, `_shadowPaint`, `_sectionFillPaint`, `_imageOverlayPaint`, `_scissorsBladePaint`, `_scissorsFillPaint`, plus a `_stackPaint` on the V painter) as `final` instance fields and mutate them in place per draw site. Previously every `paint()` call allocated 10+ short-lived `Paint` objects (Skia snapshots state at draw time, so reuse is safe).
* Both painters now cache the watermark `TextPainter` keyed by `(text, style, opacity)` so `.layout()` only runs when the watermark actually changes, not every `paint()` call.
* `BlurWrapper` now short-circuits when `blurEffect.sigma == 0`, returning the child directly. Previously it always wrapped in `BackdropFilter` / `ImageFiltered`, which forces an offscreen layer (`saveLayer`) even at zero blur.
* `VTicketcher` / `HTicketcher` now wrap their `CustomPaint` in a `RepaintBoundary`. Combined with the corrected `shouldRepaint` logic, ancestor rebuilds (theme changes, animation tickers, parent `setState`) no longer dirty the ticket layer.

### Other
* Annotated all model value-types with `@immutable`.
* Tightened `pubspec.yaml` Flutter constraint from `>=1.17.0` to `>=3.10.0` to match the actual Dart `^3.7.0` SDK requirement.
* Tightened `analysis_options.yaml` with `strict-casts`, `strict-inference`, and `strict-raw-types`.
* `lib/ticketcher.dart` now exports `ticket_clipper.dart` (`VTicketcherClipper`, `HTicketcherClipper`) which were previously public-by-name but unreachable through the package barrel.
* Extracted shared painter equality helpers (`listsEqualWithEpsilon`, `mapsEqual`, `sectionsEqual`) into `lib/src/painters/_equality.dart` so V and H painters use one source of truth.
* Added unit + widget test scaffolding (`test/helpers/`, `test/models/`, `test/painters/`, `test/widgets/`) with **49 tests** covering equality, `shouldRepaint`, `RepaintBoundary` behaviour, `BlurWrapper` fast-path, and `ImageResolver` listener lifecycle.
* Declared `screenshots:` in `pubspec.yaml` so the pub.dev landing page surfaces representative ticket designs (concert, flight, gradient, multi-section, holographic).

## 1.2.0

* Updated README documentation with comprehensive Section Gradients guide
* Added Section Gradients to Table of Contents and Features list
* Added code examples for Linear, Radial, and Sweep gradients
* Documented background precedence order for section styling
* General documentation improvements

## 1.1.0

* **NEW FEATURE**: Added section gradient background support
  * Added `gradient` property to `Section` model supporting LinearGradient, RadialGradient, and SweepGradient
  * Each section can now have its own gradient background independent of other sections
  * Updated background precedence: `backgroundImage` > `gradient` > `color` > decoration background
  * Works seamlessly with both horizontal and vertical tickets
  * Full backward compatibility maintained - existing code using `color` or `backgroundImage` continues to work
* Added comprehensive section gradient showcase example demonstrating:
  * Linear gradients in horizontal and vertical tickets
  * Radial gradients with various configurations
  * Sweep gradients with multiple color stops
  * Mixed gradient types in multi-section tickets
  * Gradient precedence examples
* Updated documentation with gradient examples and precedence order
* Enhanced `Section` model with gradient support in constructor, copyWith, equality, and hashCode

## 0.6.0

* **NEW FEATURE**: Added image background support for tickets and sections
  * Added `backgroundImage`, `backgroundImageFit`, `backgroundImageOpacity`, and `backgroundImageAlignment` properties to both `TicketcherDecoration` and `Section`
  * Support for any `ImageProvider` (NetworkImage, AssetImage, MemoryImage, FileImage)
  * Global ticket background images via `TicketcherDecoration.backgroundImage`
  * Per-section background images via `Section.backgroundImage`
  * Configurable image fit modes (cover, contain, fill, fitWidth, fitHeight, scaleDown, none)
  * Adjustable image opacity from 0.0 to 1.0
  * Custom image alignment options
  * Smart background precedence: section image > section color > decoration image > gradient > background color
  * Efficient image preloading and caching with `ImageResolver` helper class
  * Images properly clip to ticket shape including border patterns and rounded corners
  * Works with both horizontal and vertical tickets
* Added comprehensive image backgrounds showcase example demonstrating:
  * Global ticket backgrounds with different fit modes
  * Per-section backgrounds with varying opacity
  * Mixing images with solid colors and gradients
  * BoxFit mode comparisons
  * Opacity control examples
* Created `ImageResolver` helper class for efficient image loading and caching
* Full backward compatibility maintained
* Updated documentation with extensive image backgrounds examples and usage guides

## 0.5.0

* **NEW FEATURE**: Enhanced blur and glassmorphism effects with comprehensive documentation
  * Added comprehensive blur effects showcase example with 3 different blur styles
  * Enhanced README.md with organized screenshot gallery by feature categories
  * Added detailed blur effects documentation with examples and usage guides
  * Improved documentation structure and organization
  * Created feature mapping and comprehensive examples
* Full backward compatibility maintained
* Updated documentation with blur effect examples and usage

## 0.4.0

* **NEW FEATURE**: Added blur and glassmorphism effects
  * Added `BlurEffect` class with three blur styles: backdrop, frosted, and gaussian
  * Added `blurEffect` property to `TicketcherDecoration`
  * Backdrop blur: blurs content behind the ticket
  * Frosted glass: backdrop blur with customizable tinted overlay
  * Gaussian blur: applies blur to the ticket content itself
  * Configurable sigma (intensity), tint color, and opacity
  * Created `BlurWrapper` widget for efficient blur rendering
  * Works with both horizontal and vertical tickets
* Added comprehensive blur effects showcase example with 3 different blur styles
* Full backward compatibility maintained
* Updated documentation with blur effect examples and usage

## 0.0.8

* **NEW FEATURE**: Added comprehensive watermark support
  * Added `TicketWatermark` class with text and **widget watermark support**
  * Added `watermark` property to `TicketcherDecoration`
  * Support for various watermark alignments (center, corners, edges)
  * Configurable opacity, rotation, and positioning with custom offsets
  * Repeated watermark patterns across the entire ticket (text watermarks only)
  * Custom text styling for text-based watermarks
  * **Widget watermarks**: Use any Flutter widget as a watermark (icons, containers, custom layouts) - single instance only
  * Works with both horizontal and vertical tickets
* Added comprehensive watermark showcase example with 4 different watermark types
* Full backward compatibility maintained
* Updated documentation with watermark examples and usage

## 0.0.7

* **NEW FEATURE**: Added gradient border support
  * Added `borderGradient` property to `TicketcherDecoration`
  * Added `borderWidth` property for controlling gradient border thickness
  * Support for all Flutter gradient types (LinearGradient, RadialGradient, SweepGradient)
  * Gradient borders take precedence over solid borders when both are specified
  * Full backward compatibility maintained
* Added comprehensive example showcase for gradient borders
* Added extensive test coverage for gradient border functionality
* Updated documentation with gradient border examples and usage

## 0.0.6

* Added stacked effect feature for vertical tickets
* Updated README with new gallery layout
* Fixed image display issues
* Improved documentation

## 0.0.5

* Initial release

## 0.0.1

* TODO: Describe initial release.
