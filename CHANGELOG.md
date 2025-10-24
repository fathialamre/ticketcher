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
