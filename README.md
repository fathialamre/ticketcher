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

A Flutter widget that creates beautiful, customizable ticket-style UI components with various border patterns, dividers, and styling options.

## Preview

<div align="center">
  <div style="display: inline-block; margin: 0 5px;">
    <img src="screenshots/Example%201.jpeg" alt="Classic Ticket" width="200"/>
    <p>Classic Ticket</p>
  </div>
  <div style="display: inline-block; margin: 0 5px;">
    <img src="screenshots/Example%202.jpeg" alt="Gradient Ticket" width="200"/>
    <p>Gradient Ticket</p>
  </div>
  <div style="display: inline-block; margin: 0 5px;">
    <img src="screenshots/Example%203.jpeg" alt="Premium Ticket" width="200"/>
    <p>Premium Ticket</p>
  </div>
  <div style="display: inline-block; margin: 0 5px;">
    <img src="screenshots/Example%204.jpeg" alt="Minimalist Ticket" width="200"/>
    <p>Minimalist Ticket</p>
  </div>
</div>

## Features

### Basic Usage

```dart
Ticketcher(
  primarySection: Section(
    child: Text('Primary Content'),
  ),
  secondarySection: Section(
    child: Text('Secondary Content'),
  ),
)
```

### Border Radius

Customize the corners of your ticket with different radius styles and directions.

```dart
Ticketcher(
  decoration: TicketcherDecoration(
    borderRadius: TicketRadius(
      radius: 8.0,
      direction: RadiusDirection.inward, // or outward
      corner: TicketCorner.all, // or specific corners
    ),
  ),
)
```

Available corner options:
- `TicketCorner.all`: Rounds all corners
- `TicketCorner.top`: Rounds only top corners
- `TicketCorner.bottom`: Rounds only bottom corners
- `TicketCorner.topLeft`: Rounds only top-left corner
- `TicketCorner.topRight`: Rounds only top-right corner
- `TicketCorner.bottomLeft`: Rounds only bottom-left corner
- `TicketCorner.bottomRight`: Rounds only bottom-right corner
- `TicketCorner.none`: No rounded corners

### Border Patterns

Add decorative patterns to the bottom edge of your ticket.

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

Add a divider between the primary and secondary sections.

```dart
Ticketcher(
  decoration: TicketcherDecoration(
    divider: TicketDivider(
      color: Colors.grey,
      thickness: 1.0,
      style: DividerStyle.solid, // or dashed
    ),
  ),
)
```

For dashed dividers:
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

### Section Padding

Customize the padding for both primary and secondary sections.

```dart
Ticketcher(
  primarySection: Section(
    child: Text('Primary Content'),
    padding: EdgeInsets.all(16.0),
  ),
  secondarySection: Section(
    child: Text('Secondary Content'),
    padding: EdgeInsets.all(16.0),
  ),
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

Customize the radius of the notches that connect the primary and secondary sections.

```dart
Ticketcher(
  notchRadius: 10.0,
  // ... other properties
)
```

## Complete Example

Here's a complete example showcasing multiple features:

```dart
Ticketcher(
  width: 300.0,
  notchRadius: 10.0,
  primarySection: Section(
    child: Text('Primary Content'),
    padding: EdgeInsets.all(16.0),
  ),
  secondarySection: Section(
    child: Text('Secondary Content'),
    padding: EdgeInsets.all(16.0),
  ),
  decoration: TicketcherDecoration(
    borderRadius: TicketRadius(
      radius: 8.0,
      direction: RadiusDirection.inward,
      corner: TicketCorner.all,
    ),
    gradient: LinearGradient(
      colors: [Colors.blue, Colors.purple],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    divider: TicketDivider.dashed(
      color: Colors.white,
      thickness: 1.0,
      dashWidth: 10.0,
      dashSpace: 7.0,
    ),
    bottomBorderStyle: BorderPattern(
      shape: BorderShape.wave,
      height: 8.0,
      width: 20.0,
    ),
    shadow: BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 4.0,
      offset: Offset(0, 2),
    ),
  ),
)
```

## Best Practices

1. **Gradient Usage**: When using gradients, ensure good contrast with your content text.
2. **Border Patterns**: Choose border patterns that complement your overall design.
3. **Notch Radius**: Keep the notch radius proportional to your ticket's size.
4. **Padding**: Use consistent padding values for a polished look.
5. **Shadow**: Use subtle shadows to create depth without overwhelming the design.

## Contributing

Feel free to contribute to this project by submitting issues or pull requests.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.

## Visual Examples

Here are some visual examples showcasing different styles and configurations of the Ticketcher widget:

### Example 1: Classic Ticket Design
![Classic Ticket Design](screenshots/Example%201.jpeg)
A clean, classic ticket design featuring a solid background with rounded corners and a subtle divider between sections. Perfect for event tickets or vouchers.

### Example 2: Gradient Ticket with Wave Pattern
![Gradient Ticket with Wave Pattern](screenshots/Example%202.jpeg)
A modern ticket design using a gradient background and a decorative wave pattern at the bottom. The design includes a dashed divider for added visual interest.

### Example 3: Premium Ticket Style
![Premium Ticket Style](screenshots/Example%203.jpeg)
A premium-looking ticket with a sophisticated gradient background, sharp border pattern, and elegant typography. Ideal for high-end events or premium services.

### Example 4: Minimalist Ticket Design
![Minimalist Ticket Design](screenshots/Example%204.jpeg)
A minimalist ticket design featuring a clean layout, subtle shadows, and a simple arc pattern. Perfect for modern, clean interfaces.
