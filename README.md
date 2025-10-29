<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

<p align="center">
  <img src="https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/ticketcher.png" width="300" alt="Ticketcher Logo">
</p>

<p align="center">
  <a href="https://pub.dev/packages/ticketcher"><img src="https://img.shields.io/pub/v/ticketcher.svg" alt="Pub Version"></a>
  <a href="https://pub.dev/packages/ticketcher/score"><img src="https://img.shields.io/pub/points/ticketcher.svg" alt="Pub Points"></a>
  <a href="https://pub.dev/packages/ticketcher/score"><img src="https://img.shields.io/pub/likes/ticketcher.svg" alt="Pub Likes"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT"></a>
</p>

# Ticketcher

Ticketcher is a powerful Flutter 
package for creating beautiful, 
highly customizable ticket-style 
cards and widgets. Effortlessly 
design event tickets, boarding 
passes, coupons, and more with 
support for unique border 
patterns, 
gradient backgrounds, custom 
notches, and flexible section 
layouts. Ticketcher makes it easy 
to add professional, interactive 
ticket designs to your Flutter 
apps with just a few lines of 
code.


| ![Concert Ticket](https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/horizontal_1.jpeg)<br>Concert<br>Wave Divider | ![Flight Ticket](https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/flight.jpeg)<br>Flight<br>Dashed Divider | ![Gradient](https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/gradient.jpeg)<br>Gradient<br>Background | ![Train Ticket](https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/horizontal_2.jpeg)<br>Train<br>Solid Divider |
|:---:|:---:|:---:|:---:|
| ![Circle Divider](https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/circle_divider.jpeg)<br>Circle<br>Pattern | ![Wave Divider](https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/wave_divider.jpeg)<br>Wave<br>Pattern | ![Smooth Wave](https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/smooth_wave_divider.jpeg)<br>Smooth<br>Wave | ![Multiple Sections](https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/flight_multiple_section.jpeg)<br>Multiple<br>Sections |
| ![Coffee Sales](https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/coffer_sales.jpeg)<br>Coffee<br>Sales | ![Stacked Effect](https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/stacked_effect.jpeg)<br>Stacked<br>Layers | ![Colored Sections](https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/colored_sections.jpeg)<br>Colored<br>Sections | ![Gradient Background](https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/gradient_background.png)<br>Gradient<br>Background |
| ![Holographic Effects](https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/holograplic_effects.png)<br>Holographic<br>Effects | ![Image Background 1](https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/background_image_1.jpeg)<br>Image<br>Background | ![Image Background 2](https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/background_image_2.jpeg)<br>Image<br>Backgrounds | ![Gradient Border](https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/gradient_border.jpeg)<br>Gradient<br>Border |

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
  - [Basic Usage](#basic-usage)
  - [Horizontal Mode](#horizontal-mode)
  - [Vertical Mode](#vertical-mode)
  - [Interactive Sections](#interactive-sections)
  - [Border Patterns](#border-patterns)
  - [Dividers](#dividers)
    - [Solid Divider](#solid-divider)
    - [Dashed Divider](#dashed-divider)
    - [Circle Divider](#circle-divider)
    - [Wave Divider](#wave-divider)
    - [Smooth Wave Divider](#smooth-wave-divider)
    - [Dotted Divider](#dotted-divider)
    - [Double Line Divider](#double-line-divider)
  - [Background Styling](#background-styling)
    - [Solid Color](#solid-color)
    - [Gradient](#gradient)
    - [Image Backgrounds](#image-backgrounds-new)
  - [Colored Sections](#colored-sections)
  - [Border](#border)
    - [Solid Color Border](#solid-color-border)
    - [Gradient Border](#gradient-border-new)
  - [Watermarks](#watermarks-new)
    - [Text Watermarks](#text-watermarks)
    - [Widget Watermarks](#widget-watermarks)
    - [Watermark Positioning](#watermark-positioning)
    - [Watermark Styling](#watermark-styling)
  - [Blur Effects](#blur-effects-new)
    - [Backdrop Blur](#backdrop-blur)
    - [Frosted Glass](#frosted-glass)
    - [Gaussian Blur](#gaussian-blur)
  - [Shadow](#shadow)
  - [Stacked Effect](#stacked-effect)
  - [Section Padding](#section-padding)
  - [Width Control](#width-control)
  - [Notch Radius](#notch-radius)
- [Important Usage Notes](#important-usage-notes)
  - [Assertions](#assertions)
  - [Best Practices](#best-practices)
- [Examples](#examples)
- [Contributing](#contributing)
- [License](#license)

## Features

- Create both vertical and horizontal ticket layouts
- Interactive sections with individual tap callbacks
- Customizable border patterns (wave, arc, sharp)
- Multiple divider styles (solid, dashed, circles, wave, smooth wave, dotted, double line)
- Gradient backgrounds and gradient borders
- **✨ Image Backgrounds**: Global ticket or per-section image backgrounds with opacity and fit controls
- **✨ Watermarks**: Text and widget watermarks with positioning, opacity, and rotation
- **✨ Blur Effects**: Backdrop blur, frosted glass, and gaussian blur for modern glassmorphism aesthetics
- Custom border radius for any corner
- Shadow effects
- Section padding control
- Width and height control
- Notch radius customization
- Stacked effect for vertical tickets (creates a layered appearance in the last section)
- Individual background colors for each section

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  ticketcher: ^0.6.0
```

## Usage

### Basic Usage

The default mode is vertical. Here's a basic example:

```dart
Ticketcher(
  sections: [
    Section(
      child: Text('First Section'),
    ),
    Section(
      child: Text('Second Section'),
    ),
  ],
)
```

### Horizontal Mode

For horizontal layout, use the `horizontal` constructor:

| ![Horizontal Ticket 1](https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/horizontal_1.jpeg) | ![Horizontal Ticket 2](https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/horizontal_2.jpeg) |
|:---:|:---:|

```dart
Ticketcher.horizontal(
  height: 160,
  sections: [
    Section(
      widthFactor: 1,
      child: Text('Left Section'),
    ),
    Section(
      widthFactor: 2,
      child: Text('Right Section'),
    ),
  ],
)
```

### Vertical Mode

For vertical layout, you can use either the default constructor or the explicit `vertical` constructor:

```dart
Ticketcher.vertical(
  sections: [
    Section(
      child: Text('Top Section'),
    ),
    Section(
      child: Text('Bottom Section'),
    ),
  ],
)
```

### Interactive Sections

Make your tickets interactive by adding tap callbacks to individual sections. Each section can have its own `onTap` function that gets called when the user taps on that specific section.

```dart
Ticketcher(
  sections: [
    Section(
      child: Text('Header Section'),
      onTap: () {
        print('Header tapped!');
        // Handle header tap
      },
    ),
    Section(
      child: Text('Content Section'),
      onTap: () {
        print('Content tapped!');
        // Handle content tap
      },
    ),
    Section(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'TAP TO CHECK-IN',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onTap: () {
        // Handle check-in action
        _performCheckIn();
      },
    ),
  ],
)
```

#### Interactive Examples

**Flight Ticket with Check-in:**
```dart
Ticketcher(
  sections: [
    Section(
      child: FlightHeader(),
      onTap: () => _showFlightDetails(),
    ),
    Section(
      child: FlightInfo(),
      onTap: () => _showRouteMap(),
    ),
    Section(
      child: CheckInButton(),
      onTap: () => _performCheckIn(),
    ),
  ],
)
```

**Event Ticket with QR Code:**
```dart
Ticketcher.horizontal(
  height: 200,
  sections: [
    Section(
      widthFactor: 2,
      child: EventDetails(),
      onTap: () => _showEventInfo(),
    ),
    Section(
      child: QRCodeWidget(),
      onTap: () => _showQRCode(),
    ),
  ],
)
```

The `onTap` callback is completely optional. Sections without an `onTap` callback will not respond to taps, while sections with `onTap` will show a subtle tap effect and call your function when pressed.

### Border Patterns

Add decorative patterns to the edges of your ticket.

```dart
Ticketcher(
  decoration: TicketcherDecoration(
    bottomBorderStyle: BorderPattern(
      shape: BorderShape.wave, // or sharp, arc
      height: 8.0,
      width: 20.0,
    ),
  ),
)
```

Available patterns:
- `BorderShape.wave`: Creates a wavy pattern
- `BorderShape.sharp`: Creates a zigzag pattern
- `BorderShape.arc`: Creates a series of connected arcs

### Dividers

Add dividers between sections with various styles.

Available divider styles:
- `DividerStyle.solid` - A simple straight line
- `DividerStyle.dashed` - A line made of dashes
- `DividerStyle.circles` - A series of circles
- `DividerStyle.wave` - A zigzag wave pattern
- `DividerStyle.smoothWave` - A smooth curved wave pattern
- `DividerStyle.dotted` - A series of evenly spaced dots
- `DividerStyle.doubleLine` - Two parallel lines

```dart
Ticketcher(
  decoration: TicketcherDecoration(
    divider: TicketDivider(
      color: Colors.grey,
      thickness: 1.0,
      style: DividerStyle.solid, // or dashed, circles, wave, smoothWave, dotted, doubleLine
    ),
  ),
)
```

#### Solid Divider
```dart
Ticketcher(
  decoration: TicketcherDecoration(
    divider: TicketDivider.solid(
      color: Colors.grey,
      thickness: 1.0,
      padding: 8.0, // Add padding on both sides
    ),
  ),
)
```

#### Dashed Divider
```dart
Ticketcher(
  decoration: TicketcherDecoration(
    divider: TicketDivider.dashed(
      color: Colors.grey,
      thickness: 1.0,
      dashWidth: 10.0,
      dashSpace: 7.0,
      padding: 8.0, // Add padding on both sides
    ),
  ),
)
```

#### Circle Divider

<p align="center">
  <img src="https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/circle_divider.jpeg" width="250" alt="Circle Divider Example">
</p>

```dart
Ticketcher(
  decoration: TicketcherDecoration(
    divider: TicketDivider.circles(
      color: Colors.grey,
      thickness: 2.0,
      circleRadius: 4.0,
      circleSpacing: 8.0,
      padding: 8.0, // Add padding on both sides
    ),
  ),
)
```

#### Wave Divider

<p align="center">
  <img src="https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/wave_divider.jpeg" width="250" alt="Wave Divider Example">
</p>

```dart
Ticketcher(
  decoration: TicketcherDecoration(
    divider: TicketDivider.wave(
      color: Colors.grey,
      thickness: 2.0,
      waveHeight: 6.0,
      waveWidth: 12.0,
      padding: 8.0, // Add padding on both sides
    ),
  ),
)
```

#### Smooth Wave Divider

<p align="center">
  <img src="https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/smooth_wave_divider.jpeg" width="250" alt="Smooth Wave Divider Example">
</p>

```dart
Ticketcher(
  decoration: TicketcherDecoration(
    divider: TicketDivider.smoothWave(
      color: Colors.grey,
      thickness: 2.0,
      waveHeight: 6.0,
      waveWidth: 12.0,
      padding: 8.0, // Add padding on both sides
    ),
  ),
)
```

#### Dotted Divider
```dart
Ticketcher(
  decoration: TicketcherDecoration(
    divider: TicketDivider.dotted(
      color: Colors.grey,
      thickness: 2.0,
      dotSize: 2.0,
      dotSpacing: 8.0,
      padding: 8.0, // Add padding on both sides
    ),
  ),
)
```

#### Double Line Divider
```dart
Ticketcher(
  decoration: TicketcherDecoration(
    divider: TicketDivider.doubleLine(
      color: Colors.grey,
      thickness: 1.5,
      lineSpacing: 4.0,
      padding: 8.0, // Add padding on both sides
    ),
  ),
)
```

The `padding` property adds equal spacing on both sides of the divider. This is useful when you want to create some space between the divider and the edges of the ticket. The padding is applied symmetrically, meaning the same amount of space is added to both the left and right sides in vertical mode, or top and bottom sides in horizontal mode.

### Background Styling

#### Solid Color
```dart
Ticketcher(
  decoration: TicketcherDecoration(
    backgroundColor: Colors.white,
  ),
)
```

#### Gradient

| ![Gradient Example](https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/gradient.jpeg) | ![Gradient Background](https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/gradient_background.png) |
|:---:|:---:|

```dart
Ticketcher(
  decoration: TicketcherDecoration(
    gradient: LinearGradient(
      colors: [Colors.blue, Colors.purple],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
)
```

#### Image Backgrounds ✨ NEW

Add background images to your entire ticket or individual sections. Images support various fit modes, opacity control, and alignment options.

| ![Image Background Example 1](https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/background_image_1.jpeg) | ![Image Background Example 2](https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/background_image_2.jpeg) |
|:---:|:---:|

**Global Ticket Background:**
```dart
Ticketcher(
  decoration: TicketcherDecoration(
    backgroundImage: NetworkImage('https://example.com/image.jpg'),
    backgroundImageFit: BoxFit.cover,
    backgroundImageOpacity: 0.8,
    backgroundImageAlignment: Alignment.center,
  ),
  sections: [
    Section(child: Text('Section 1')),
    Section(child: Text('Section 2')),
  ],
)
```

**Per-Section Background Images:**
```dart
Ticketcher(
  sections: [
    Section(
      backgroundImage: AssetImage('assets/section1.png'),
      backgroundImageFit: BoxFit.cover,
      backgroundImageOpacity: 0.9,
      child: Text('First Section'),
    ),
    Section(
      backgroundImage: NetworkImage('https://example.com/section2.jpg'),
      backgroundImageFit: BoxFit.contain,
      backgroundImageOpacity: 1.0,
      child: Text('Second Section'),
    ),
  ],
)
```

**Image Properties:**
- `backgroundImage`: Any `ImageProvider` (AssetImage, NetworkImage, MemoryImage, FileImage)
- `backgroundImageFit`: How to fit the image (BoxFit.cover, contain, fill, fitWidth, fitHeight, scaleDown, none)
- `backgroundImageOpacity`: Opacity from 0.0 (transparent) to 1.0 (opaque)
- `backgroundImageAlignment`: How to align the image (Alignment.center, topLeft, bottomRight, etc.)

**Background Precedence Order:**
1. Section `backgroundImage` (highest priority)
2. Section `color`
3. Decoration `backgroundImage`
4. Decoration `gradient`
5. Decoration `backgroundColor` (lowest priority)

**Combining Images with Other Backgrounds:**
```dart
Ticketcher(
  decoration: TicketcherDecoration(
    // Global background image
    backgroundImage: NetworkImage('https://example.com/texture.jpg'),
    backgroundImageOpacity: 0.3,
  ),
  sections: [
    Section(
      // Section-specific solid color overlays the global image
      color: Colors.blue.withOpacity(0.7),
      child: Text('Section with Color'),
    ),
    Section(
      // Section-specific image overrides everything
      backgroundImage: AssetImage('assets/special.png'),
      child: Text('Section with Image'),
    ),
  ],
)
```

### Colored Sections

Customize the background color of individual sections. If a section `color` is provided, it overrides the `backgroundColor` and `gradient` from `TicketcherDecoration` for that specific section. This allows for creating tickets with multi-colored parts.

<p align="center">
  <img src="https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/colored_sections.jpeg" width="250" alt="Colored Sections Example">
</p>

```dart
Ticketcher(
  sections: [
    Section(
      color: Colors.blue.shade100,
      child: Text('First Section'),
    ),
    Section(
      color: Colors.green.shade100,
      child: Text('Second Section'),
    ),
  ],
)
```

### Border

Add a border around your ticket using either solid colors or gradients.

#### Solid Color Border
```dart
Ticketcher(
  decoration: TicketcherDecoration(
    border: Border.all(
      color: Colors.grey,
      width: 1.0,
    ),
  ),
)
```

#### Gradient Border (New!)
Create stunning visual effects with gradient borders using any Flutter gradient type.

<p align="center">
  <img src="https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/gradient_border.jpeg" width="250" alt="Gradient Border Example">
</p>

```dart
// Linear gradient border
Ticketcher(
  decoration: TicketcherDecoration(
    borderGradient: LinearGradient(
      colors: [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue],
    ),
    borderWidth: 3.0,
  ),
)

// Radial gradient border
Ticketcher(
  decoration: TicketcherDecoration(
    borderGradient: RadialGradient(
      colors: [Colors.purple, Colors.pink, Colors.orange],
    ),
    borderWidth: 2.5,
  ),
)

// Sweep gradient for rainbow effects
Ticketcher(
  decoration: TicketcherDecoration(
    borderGradient: SweepGradient(
      colors: [
        Colors.red, Colors.orange, Colors.yellow, Colors.green,
        Colors.blue, Colors.indigo, Colors.purple, Colors.red,
      ],
    ),
    borderWidth: 2.0,
  ),
)
```

**Note**: When both `border` and `borderGradient` are specified, the gradient border takes precedence. Use `borderWidth` to control the thickness of gradient borders.

## Watermarks (New!)

Add text or widget watermarks to your tickets for branding, security, or decorative purposes. Watermarks support positioning, opacity, rotation, and custom styling.

### Text Watermarks

Create text-based watermarks with custom styling and effects.

```dart
Ticketcher(
  decoration: TicketcherDecoration(
    watermark: TicketWatermark.text(
      text: 'CONFIDENTIAL',
      opacity: 0.3,
      alignment: WatermarkAlignment.center,
      rotation: 45, // Rotate 45 degrees
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),
    ),
  ),
)
```

### Widget Watermarks

Use any Flutter widget as a watermark, including icons, containers, or custom layouts.

> **Note**: Widget watermarks do not support repeat functionality for performance reasons. If you need repeating patterns, use text watermarks instead.

```dart
// Icon watermark
Ticketcher(
  decoration: TicketcherDecoration(
    watermark: TicketWatermark.widget(
      widget: Icon(
        Icons.verified,
        size: 80,
        color: Colors.blue,
      ),
      opacity: 0.2,
      alignment: WatermarkAlignment.center,
      rotation: 15,
    ),
  ),
)

// Custom widget watermark
Ticketcher(
  decoration: TicketcherDecoration(
    watermark: TicketWatermark.widget(
      widget: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.amber.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.amber, width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, color: Colors.amber, size: 16),
            SizedBox(width: 4),
            Text(
              'PREMIUM',
              style: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      opacity: 0.7,
      alignment: WatermarkAlignment.topRight,
      offset: Offset(-10, 10), // Custom positioning
    ),
  ),
)
```

### Watermark Positioning

Control where your watermark appears with precise positioning options:

```dart
// Available alignment options
WatermarkAlignment.topLeft
WatermarkAlignment.topCenter
WatermarkAlignment.topRight
WatermarkAlignment.centerLeft
WatermarkAlignment.center
WatermarkAlignment.centerRight
WatermarkAlignment.bottomLeft
WatermarkAlignment.bottomCenter
WatermarkAlignment.bottomRight

// Example with custom offset
TicketWatermark.text(
  text: 'SAMPLE',
  alignment: WatermarkAlignment.bottomRight,
  offset: Offset(-20, -20), // 20 pixels from bottom and right edges
)
```

### Watermark Styling

Customize appearance with opacity, rotation, and size controls:

```dart
TicketWatermark.text(
  text: 'DRAFT',
  opacity: 0.15,        // Very subtle
  rotation: 30,         // Rotate 30 degrees
  alignment: WatermarkAlignment.center,
  style: TextStyle(
    fontSize: 64,
    fontWeight: FontWeight.w900,
    color: Colors.grey,
  ),
)

// Repeated text watermarks across the ticket (only available for text watermarks)
TicketWatermark.text(
  text: 'COPY',
  repeat: true,         // Repeat across ticket
  repeatSpacing: 50,    // Space between repetitions
  opacity: 0.1,
  rotation: 15,
)

// Note: Widget watermarks do not support repeat functionality for performance reasons.
// If you need repeated patterns, use text watermarks instead.
```

**Note**: Watermarks are rendered above the ticket content but below any interactive elements. For best results, use semi-transparent opacity values (0.1 - 0.3) to maintain content readability.

## Blur Effects (New!)

Add modern blur and glassmorphism effects to your tickets for premium, contemporary designs. Perfect for creating frosted glass aesthetics, backdrop filters, and soft focus effects.

<p align="center">
  <img src="https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/holograplic_effects.png" width="250" alt="Blur Effects Example">
</p>

### Backdrop Blur

Creates a backdrop filter that blurs content behind the ticket while keeping the ticket content sharp.

```dart
Ticketcher(
  decoration: TicketcherDecoration(
    backgroundColor: Colors.white.withOpacity(0.1),
    blurEffect: BlurEffect.backdrop(sigma: 10.0),
    borderRadius: const TicketRadius(radius: 16),
    shadow: BoxShadow(
      color: Colors.black.withOpacity(0.3),
      blurRadius: 20,
      offset: const Offset(0, 10),
    ),
  ),
)
```

### Frosted Glass

Creates a frosted glass effect with backdrop blur and a tinted overlay for a premium glassmorphism aesthetic.

```dart
Ticketcher(
  decoration: TicketcherDecoration(
    backgroundColor: Colors.transparent,
    blurEffect: BlurEffect.frosted(
      sigma: 15.0,
      tintColor: Colors.white,
      opacity: 0.15,
    ),
    borderRadius: const TicketRadius(radius: 16),
    border: Border.all(
      color: Colors.white.withOpacity(0.2),
      width: 1.5,
    ),
  ),
)
```

### Gaussian Blur

Applies blur directly to the ticket content itself for a soft focus effect.

```dart
Ticketcher(
  decoration: TicketcherDecoration(
    backgroundColor: Colors.white.withOpacity(0.9),
    blurEffect: BlurEffect.gaussian(sigma: 3.0),
    borderRadius: const TicketRadius(radius: 12),
  ),
)
```

#### Blur Effect Configuration

```dart
// Custom blur effect with full control
BlurEffect(
  sigma: 10.0,                    // Blur intensity (0-30)
  style: BlurStyle.frosted,       // backdrop, frosted, or gaussian
  tintColor: Colors.white,        // Overlay color for frosted effect
  opacity: 0.2,                   // Overlay opacity (0.0-1.0)
)

// Available blur styles
BlurEffect.backdrop(sigma: 10.0)     // Blurs background content
BlurEffect.frosted(                  // Frosted glass with tint
  sigma: 15.0,
  tintColor: Colors.white,
  opacity: 0.15,
)
BlurEffect.gaussian(sigma: 5.0)      // Blurs ticket content
```

**Note**: Blur effects work best with semi-transparent backgrounds and are perfect for creating modern glassmorphism designs. The `sigma` parameter controls blur intensity - higher values create more blur.

### Shadow

Add a shadow effect to your ticket.

```dart
Ticketcher(
  decoration: TicketcherDecoration(
    shadow: BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 4.0,
      offset: Offset(0, 2),
    ),
  ),
)
```

### Stacked Effect

Add a stacked effect to your vertical ticket's last section. This creates a layered appearance that adds depth to your ticket design.

<p align="center">
  <img src="https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/stacked_effect.jpeg" width="250" alt="Stacked Effect Example">
</p>

```dart
Ticketcher(
  decoration: TicketcherDecoration(
    stackEffect: StackEffect(
      count: 2, // Number of stacked layers
      offset: 8.0, // Vertical offset between layers
      widthStep: 4.0, // Width reduction for each layer
      color: Colors.grey.withOpacity(0.2), // Color of the stacked layers
    ),
  ),
)
```

The stacked effect is only supported in vertical tickets and will be applied to the last section. You can customize:
- `count`: Number of stacked layers (1-3)
- `offset`: Vertical offset between each layer
- `widthStep`: How much each layer is reduced in width
- `color`: Color of the stacked layers (defaults to a light grey if not specified)

Example with a more pronounced effect:
```dart
Ticketcher(
  decoration: TicketcherDecoration(
    stackEffect: StackEffect(
      count: 3,
      offset: 12.0,
      widthStep: 8.0,
      color: Colors.blue.withOpacity(0.1),
    ),
  ),
)
```

Note: The stacked effect is only available in vertical tickets and will be ignored in horizontal tickets.

### Section Padding

Customize the padding for each section.

```dart
Ticketcher(
  sections: [
    Section(
      child: Text('First Section'),
      padding: EdgeInsets.all(16.0),
    ),
    Section(
      child: Text('Second Section'),
      padding: EdgeInsets.all(16.0),
    ),
  ],
)
```

### Width Control

Set a specific width for your ticket.

```dart
Ticketcher(
  width: 300.0,
  // ... other properties
)
```

### Notch Radius

Customize the radius of the notches that connect the sections.

```dart
Ticketcher(
  notchRadius: 12.0,
  // ... other properties
)
```

## Important Usage Notes

### Assertions

The package includes several assertions to prevent invalid configurations:

1. **Minimum Sections**
   - Both vertical and horizontal tickets must have at least 2 sections
   - Error message: "Vertical/Horizontal Ticketcher must have at least 2 sections"

2. **Border Style and Radius Conflicts**
   - In vertical mode, you cannot use `bottomBorderStyle` when there's a bottom border radius
   - Error message: "Cannot use bottomBorderStyle when there is a bottom border radius"
   - This applies to any bottom corner radius (bottom, bottomLeft, bottomRight, or all corners)

### Best Practices

1. **Section Width Factors**
   - In horizontal mode, use `widthFactor` to control section widths
   - The total of all width factors determines the relative sizes
   - Example: `widthFactor: 1` and `widthFactor: 2` creates a 1:2 ratio

2. **Border Patterns**
   - Border patterns work best with straight edges
   - Avoid using border patterns on edges with rounded corners
   - For best results, use patterns on edges without radius

3. **Dividers**
   - Choose divider styles that complement your border patterns
   - Consider using matching colors for borders and dividers
   - Adjust thickness and spacing for better visual balance

4. **Performance**
   - Use `width` and `height` properties when you know the exact dimensions
   - This helps avoid unnecessary layout calculations
   - For dynamic content, let the widget calculate its own size

## Examples

### Gradient Border Showcase

Here are some popular gradient border combinations:

```dart
// Neon cyber border
Ticketcher(
  decoration: TicketcherDecoration(
    backgroundColor: Colors.black,
    borderGradient: LinearGradient(
      colors: [Color(0xFF00FFFF), Color(0xFF0080FF), Color(0xFF8000FF), Color(0xFFFF00FF)],
    ),
    borderWidth: 2.5,
    shadow: BoxShadow(
      color: Colors.cyan.withOpacity(0.5),
      blurRadius: 15,
      spreadRadius: 2,
    ),
  ),
)

// Sunset gradient border
Ticketcher(
  decoration: TicketcherDecoration(
    backgroundColor: Colors.white,
    borderGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFFFD89B), Color(0xFFFF8A56), Color(0xFFFF6B6B)],
    ),
    borderWidth: 2.0,
  ),
)

// Metallic gold border
Ticketcher(
  decoration: TicketcherDecoration(
    backgroundColor: Colors.white,
    borderGradient: LinearGradient(
      colors: [Color(0xFFFFD700), Color(0xFFFFA500), Color(0xFFFFD700), Color(0xFFB8860B)],
    ),
    borderWidth: 3.0,
    shadow: BoxShadow(
      color: Colors.amber.withOpacity(0.3),
      blurRadius: 8,
    ),
  ),
)
```

### Blur Effects Showcase

Here are some popular blur effect combinations for modern glassmorphism designs:

```dart
// Premium frosted glass ticket
Ticketcher(
  decoration: TicketcherDecoration(
    backgroundColor: Colors.transparent,
    blurEffect: BlurEffect.frosted(
      sigma: 15.0,
      tintColor: Colors.white,
      opacity: 0.1,
    ),
    borderRadius: const TicketRadius(radius: 16),
    border: Border.all(
      color: Colors.white.withOpacity(0.3),
      width: 1.5,
    ),
    shadow: BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 20,
      offset: const Offset(0, 10),
    ),
  ),
)

// Backdrop blur with gradient background
Ticketcher(
  decoration: TicketcherDecoration(
    backgroundColor: Colors.white.withOpacity(0.05),
    blurEffect: BlurEffect.backdrop(sigma: 12.0),
    borderRadius: const TicketRadius(radius: 20),
    divider: TicketDivider.smoothWave(
      color: Colors.white.withOpacity(0.4),
      thickness: 2,
    ),
  ),
)

// Soft focus gaussian blur
Ticketcher(
  decoration: TicketcherDecoration(
    backgroundColor: Colors.white.withOpacity(0.8),
    blurEffect: BlurEffect.gaussian(sigma: 2.5),
    borderRadius: const TicketRadius(radius: 12),
  ),
)
```

Check out the [example](example) directory for more detailed examples of different ticket styles and configurations, including the new blur effects showcase and gradient border examples.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
