# Release Notes - Ticketcher 0.6.0

## 🎉 New Feature: Image Backgrounds

We're thrilled to announce the release of **Ticketcher 0.6.0** with a powerful new feature that lets you add stunning image backgrounds to your tickets!

### 🖼️ Image Background Support

You can now add background images to your entire ticket or individual sections, giving you complete creative control over your ticket designs.

#### Key Features:

- **Global Ticket Backgrounds**: Apply a single image to cover your entire ticket
- **Per-Section Backgrounds**: Use different images for each section of your ticket
- **Multiple Image Sources**: Support for all Flutter ImageProvider types:
  - `NetworkImage` - Load images from URLs
  - `AssetImage` - Use local asset images
  - `MemoryImage` - Use in-memory image data
  - `FileImage` - Load from file system
- **Flexible Image Fitting**: All BoxFit modes supported:
  - `cover` - Fill the space, may crop
  - `contain` - Fit within bounds, maintain aspect ratio
  - `fill` - Stretch to fill exactly
  - `fitWidth`, `fitHeight`, `scaleDown`, `none`
- **Opacity Control**: Adjustable transparency from 0.0 (fully transparent) to 1.0 (fully opaque)
- **Custom Alignment**: Position images exactly where you want them
- **Smart Precedence**: Backgrounds render in logical order:
  1. Section `backgroundImage` (highest priority)
  2. Section `color`
  3. Decoration `backgroundImage`
  4. Decoration `gradient`
  5. Decoration `backgroundColor` (lowest priority)

### 🚀 Performance & Implementation

- **Efficient Image Loading**: New `ImageResolver` class handles asynchronous loading with smart caching
- **Optimized Rendering**: Images are properly clipped to ticket shapes, respecting border patterns and rounded corners
- **Works Everywhere**: Supports both horizontal and vertical ticket layouts

### 📝 Usage Examples

#### Global Ticket Background
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

#### Per-Section Backgrounds
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

### 📚 Documentation Updates

- Added comprehensive image backgrounds documentation
- New showcase example demonstrating various use cases
- Updated README with visual examples
- Added images to all relevant sections for better understanding

### 🔧 Technical Details

**New Files:**
- `lib/src/painters/image_resolver.dart` - Image loading and caching helper

**Modified Files:**
- `lib/src/models/section.dart` - Added image background properties
- `lib/src/models/ticketcher_decoration.dart` - Added image background properties
- `lib/src/painters/vticketcher_painter.dart` - Image painting support
- `lib/src/painters/hticketcher_painter.dart` - Image painting support
- `lib/src/widgets/vticketcher.dart` - Image preloading
- `lib/src/widgets/hticketcher.dart` - Image preloading
- `example/lib/show_cases/image_background_showcase.dart` - New showcase example

### ✨ What's Next?

Stay tuned for more exciting features in future releases! We're always working to make Ticketcher even better.

### 📦 Installation

Update your `pubspec.yaml`:

```yaml
dependencies:
  ticketcher: ^0.6.0
```

### 🔗 Links

- [Documentation](https://pub.dev/packages/ticketcher)
- [GitHub Repository](https://github.com/fathialamre/ticketcher)
- [Issue Tracker](https://github.com/fathialamre/ticketcher/issues)

### 🙏 Thank You

Thank you for using Ticketcher! Your support and feedback help us make this package better with every release.

---

**Full Changelog**: See [CHANGELOG.md](CHANGELOG.md) for detailed changes.

