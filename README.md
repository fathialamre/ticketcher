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

# Ticketcher

A Flutter package for creating beautiful ticket-style cards with customizable borders, dividers, and patterns.

| ![Horizontal Ticket Example](screenshots/horizontal.jpeg) | ![Circle Divider Example](screenshots/circle_divider.jpeg) | ![Wave Divider Example](screenshots/wave_divider.jpeg) | ![Smooth Wave Divider Example](screenshots/smooth_wave_divider.jpeg) |
|:---:|:---:|:---:|:---:|
| *Horizontal Ticket* | *Circle Divider* | *Wave Divider* | *Smooth Wave Divider* |

| ![Flight Ticket Example](screenshots/flight.jpeg) | ![Flight Multiple Section Example](screenshots/flight_multiple_section.jpeg) | ![Gradient Example](screenshots/gradient.jpeg) | ![Social Media Example](screenshots/social_media.jpeg) |
|:---:|:---:|:---:|:---:|
| *Flight Ticket* | *Flight Multiple Section* | *Gradient* | *Social Media* |

## Features

- Create both vertical and horizontal ticket layouts
- Customizable border patterns (wave, arc, sharp)
- Multiple divider styles (solid, dashed, circles, wave, smooth wave)
- Gradient backgrounds
- Custom border radius for any corner
- Shadow effects
- Section padding control
- Width and height control
- Notch radius customization

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  ticketcher: ^1.0.0
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

```dart
Ticketcher(
  decoration: TicketcherDecoration(
    divider: TicketDivider(
      color: Colors.grey,
      thickness: 1.0,
      style: DividerStyle.solid, // or dashed, circles, wave, smoothWave
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
    ),
  ),
)
```

### Background Styling

#### Solid Color
```dart
Ticketcher(
  decoration: TicketcherDecoration(
    backgroundColor: Colors.white,
  ),
)
```