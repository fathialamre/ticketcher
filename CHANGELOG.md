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
