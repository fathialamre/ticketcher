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
| ![Coffee Sales](https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/coffer_sales.jpeg)<br>Coffee<br>Sales | ![Stacked Effect](https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/stacked_effect.jpeg)<br>Stacked<br>Layers | ![Colored Sections](https://raw.githubusercontent.com/fathialamre/ticketcher/main/screenshots/colored_sections.jpeg)<br>Colored<br>Sections | |

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
  - [Basic Usage](#basic-usage)
  - [Horizontal Mode](#horizontal-mode)
  - [Vertical Mode](#vertical-mode)
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
  - [Colored Sections](#colored-sections)
  - [Border](#border)
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
- Customizable border patterns (wave, arc, sharp)
- Multiple divider styles (solid, dashed, circles, wave, smooth wave, dotted, double line)
- Gradient backgrounds
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
  ticketcher: ^0.1.0
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

### Colored Sections

Customize the background color of individual sections. If a section `color` is provided, it overrides the `backgroundColor` and `gradient` from `TicketcherDecoration` for that specific section. This allows for creating tickets with multi-colored parts.

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

Add a border around your ticket.

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

Check out the [example](example) directory for more detailed examples of different ticket styles and configurations.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
