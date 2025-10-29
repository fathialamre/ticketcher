import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// A helper class for resolving and caching images for use in custom painters.
///
/// This class manages the lifecycle of image loading and provides synchronous
/// access to cached images for efficient painting operations.
///
/// Example:
/// ```dart
/// final resolver = ImageResolver();
///
/// // Load an image
/// await resolver.resolveImage(NetworkImage('https://example.com/image.jpg'));
///
/// // Get the cached image synchronously (returns null if not loaded)
/// final image = resolver.getImage(NetworkImage('https://example.com/image.jpg'));
/// if (image != null) {
///   // Use image in painting
/// }
///
/// // Clean up when done
/// resolver.dispose();
/// ```
class ImageResolver {
  /// Cache of resolved images
  final Map<ImageProvider, ui.Image> _imageCache = {};

  /// Active image stream listeners for cleanup
  final Map<ImageProvider, ImageStreamListener> _listeners = {};

  /// Completer for tracking loading status
  final Map<ImageProvider, Completer<ui.Image?>> _loadingCompleters = {};

  /// Resolves an image from an ImageProvider and caches it.
  ///
  /// Returns the resolved [ui.Image] if successful, or null if loading fails.
  /// The image is cached for future synchronous access via [getImage].
  ///
  /// Parameters:
  /// - [provider]: The ImageProvider to resolve
  /// - [configuration]: Optional ImageConfiguration for resolution
  ///
  /// Example:
  /// ```dart
  /// final image = await resolver.resolveImage(
  ///   AssetImage('assets/background.png'),
  /// );
  /// ```
  Future<ui.Image?> resolveImage(
    ImageProvider provider, {
    ImageConfiguration configuration = ImageConfiguration.empty,
  }) async {
    // Return cached image if available
    if (_imageCache.containsKey(provider)) {
      return _imageCache[provider];
    }

    // Return existing loading operation if in progress
    if (_loadingCompleters.containsKey(provider)) {
      return _loadingCompleters[provider]!.future;
    }

    // Start new loading operation
    final completer = Completer<ui.Image?>();
    _loadingCompleters[provider] = completer;

    try {
      final ImageStream stream = provider.resolve(configuration);
      final listener = ImageStreamListener(
        (ImageInfo info, bool synchronousCall) {
          // Cache the image
          _imageCache[provider] = info.image;

          // Complete the loading operation
          if (!completer.isCompleted) {
            completer.complete(info.image);
          }

          // Clean up listener
          _cleanupListener(provider, stream);
        },
        onError: (dynamic exception, StackTrace? stackTrace) {
          // Log error and return null
          debugPrint('ImageResolver: Failed to load image: $exception');

          if (!completer.isCompleted) {
            completer.complete(null);
          }

          // Clean up listener
          _cleanupListener(provider, stream);
        },
      );

      _listeners[provider] = listener;
      stream.addListener(listener);

      return await completer.future;
    } catch (e) {
      debugPrint('ImageResolver: Error resolving image: $e');
      if (!completer.isCompleted) {
        completer.complete(null);
      }
      _loadingCompleters.remove(provider);
      return null;
    }
  }

  /// Gets a cached image synchronously.
  ///
  /// Returns the cached [ui.Image] if available, or null if the image
  /// has not been resolved yet or failed to load.
  ///
  /// Example:
  /// ```dart
  /// final image = resolver.getImage(AssetImage('assets/bg.png'));
  /// if (image != null) {
  ///   canvas.drawImage(image, offset, paint);
  /// }
  /// ```
  ui.Image? getImage(ImageProvider provider) {
    return _imageCache[provider];
  }

  /// Checks if an image is cached and ready for use.
  ///
  /// Returns true if the image has been successfully resolved and cached.
  bool hasImage(ImageProvider provider) {
    return _imageCache.containsKey(provider);
  }

  /// Checks if an image is currently being loaded.
  ///
  /// Returns true if a loading operation is in progress for this provider.
  bool isLoading(ImageProvider provider) {
    return _loadingCompleters.containsKey(provider);
  }

  /// Removes an image from the cache.
  ///
  /// This can be used to force reloading of an image or to free memory.
  void evict(ImageProvider provider) {
    _imageCache.remove(provider);
    _loadingCompleters.remove(provider);
  }

  /// Clears all cached images and cancels any in-progress loading operations.
  void clear() {
    _imageCache.clear();
    _loadingCompleters.clear();

    // Clean up all listeners
    _listeners.clear();
  }

  /// Cleans up a listener after image loading completes or fails.
  void _cleanupListener(ImageProvider provider, ImageStream stream) {
    final listener = _listeners[provider];
    if (listener != null) {
      stream.removeListener(listener);
      _listeners.remove(provider);
    }
    _loadingCompleters.remove(provider);
  }

  /// Disposes of the ImageResolver and cleans up all resources.
  ///
  /// Call this when the resolver is no longer needed to prevent memory leaks.
  void dispose() {
    clear();
  }

  /// Gets the number of cached images.
  int get cacheSize => _imageCache.length;
}
