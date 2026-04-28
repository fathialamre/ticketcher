import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/src/painters/image_resolver.dart';

import '../helpers/fake_image_provider.dart';

void main() {
  // ImageProvider.resolve requires Flutter bindings (PaintingBinding) to
  // initialize the global image cache.
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(FakeImageProvider.resetCounters);

  test('dispose() detaches the listener attached during in-flight loads',
      () async {
    final resolver = ImageResolver();
    final provider = FakeImageProvider(id: 'pending', neverComplete: true);

    // ignore: unawaited_futures
    resolver.resolveImage(provider);
    await Future<void>.delayed(const Duration(milliseconds: 50));

    // The PaintingBinding image cache also subscribes a listener, so the
    // absolute count is implementation-defined. We only assert our resolver's
    // contribution: dispose() must drop the count by 1.
    final beforeDispose = FakeImageProvider.activeListenerCount;
    expect(beforeDispose, greaterThan(0));

    resolver.dispose();

    expect(
      FakeImageProvider.activeListenerCount,
      beforeDispose - 1,
      reason:
          'dispose() must remove the resolver-owned listener from the stream.',
    );
  });

  test('successful load self-cleans the resolver listener', () async {
    final resolver = ImageResolver();
    final provider = FakeImageProvider(id: 'oneshot');

    final beforeLoad = FakeImageProvider.activeListenerCount;
    final image = await resolver.resolveImage(provider);
    expect(image, isNotNull);

    resolver.dispose();
    // After load completion + dispose, count should be back to baseline (the
    // cache may keep its own listener, but the resolver should not have added
    // a net listener).
    expect(FakeImageProvider.activeListenerCount, lessThanOrEqualTo(beforeLoad + 1));
  });

  test('evict() during in-flight load removes the resolver listener',
      () async {
    final resolver = ImageResolver();
    final provider = FakeImageProvider(id: 'pending2', neverComplete: true);

    // ignore: unawaited_futures
    resolver.resolveImage(provider);
    await Future<void>.delayed(const Duration(milliseconds: 50));
    final beforeEvict = FakeImageProvider.activeListenerCount;
    expect(beforeEvict, greaterThan(0));

    resolver.evict(provider);

    expect(FakeImageProvider.activeListenerCount, beforeEvict - 1);
    resolver.dispose();
  });
}
