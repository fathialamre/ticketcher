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
