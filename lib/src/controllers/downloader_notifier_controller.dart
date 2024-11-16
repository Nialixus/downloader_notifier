part of '../../downloader_notifier.dart';

class DownloaderNotifierController extends InheritedWidget {
  const DownloaderNotifierController({
    super.key,
    this.onError,
    this.onFinishDuration = const Duration(seconds: 5),
    required this.queue,
    required super.child,
  });
  final Duration onFinishDuration;
  final List<DownloaderNotifierProgress> queue;
  final void Function(dynamic e, StackTrace? s)? onError;

  Future<void> open(
    BuildContext context, {
    void Function(dynamic e, StackTrace? s)? onError,
    required String url,
  }) async {
    try {
      final permission = await FlDownloader.requestPermission();
      final hasPermission = permission == StoragePermissionStatus.granted;
      if (hasPermission) {
        final hasData = queue.isNotEmpty == true;
        final isRunning = hasData &&
            queue.any((where) => where.status == DownloadStatus.running);
        if (isRunning) {
          onError?.call('There is a download in progress', null);
        } else {
          await close();
          FlDownloader.download(url);
          PictureInPicture.startPiP(
            pipWidget: NavigatablePiPWidget(
              pipBorderRadius: 8.0,
              elevation: 0.0,
              onPiPClose: () {},
              builder: (x) {
                final queue = DownloaderNotifierController.of(x).queue;
                return DownloaderNotifierBar(
                  queue.isEmpty
                      ? DownloaderNotifierProgress.test(random: false)
                      : queue.last,
                  parentContext: context,
                );
              },
            ),
          );
        }
      } else {
        onError?.call('Permission denied', null);
      }
    } catch (e, s) {
      onError?.call(e, s);
    }
  }

  Future<void> close() async {
    PictureInPicture.stopPiP();
  }

  static DownloaderNotifierController? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<DownloaderNotifierController>();
  }

  static DownloaderNotifierController of(BuildContext context) {
    final DownloaderNotifierController? result = maybeOf(context);
    assert(result != null, 'No DownloaderNotifierController found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant DownloaderNotifierController oldWidget) =>
      queue != oldWidget.queue;
}
