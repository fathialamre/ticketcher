import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

/// An [ImageProvider] that tracks the number of attached/detached stream
/// listeners across its lifetime.
///
/// If [neverComplete] is true the underlying [ImageStream] never emits a
/// frame, which is useful for verifying that [ImageResolver] removes
/// listeners on dispose even while a load is in flight.
class FakeImageProvider extends ImageProvider<FakeImageProvider> {
  FakeImageProvider({this.id = 'fake', this.neverComplete = false});

  final String id;
  final bool neverComplete;

  /// Active listener count across all streams created by this provider.
  static int activeListenerCount = 0;

  static void resetCounters() {
    activeListenerCount = 0;
  }

  @override
  Future<FakeImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<FakeImageProvider>(this);
  }

  @override
  ImageStreamCompleter loadImage(
    FakeImageProvider key,
    ImageDecoderCallback decode,
  ) {
    if (neverComplete) {
      return _CountingCompleter(Completer<ImageInfo>().future);
    }
    return _CountingCompleter(_loadAsync());
  }

  Future<ImageInfo> _loadAsync() async {
    final ui.Image image = await _create1x1();
    return ImageInfo(image: image);
  }

  Future<ui.Image> _create1x1() {
    final completer = Completer<ui.Image>();
    ui.decodeImageFromPixels(
      Uint8List.fromList(<int>[0, 0, 0, 0]),
      1,
      1,
      ui.PixelFormat.rgba8888,
      completer.complete,
    );
    return completer.future;
  }

  @override
  bool operator ==(Object other) =>
      other is FakeImageProvider && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

class _CountingCompleter extends OneFrameImageStreamCompleter {
  _CountingCompleter(super.image);

  @override
  void addListener(ImageStreamListener listener) {
    FakeImageProvider.activeListenerCount++;
    super.addListener(listener);
  }

  @override
  void removeListener(ImageStreamListener listener) {
    FakeImageProvider.activeListenerCount--;
    super.removeListener(listener);
  }
}

