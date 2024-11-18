// ignore_for_file: use_build_context_synchronously

part of '../../downloader_notifier.dart';

enum DownloaderNotifierType {
  float,
  embedded;
}

class DownloaderNotifierBar extends StatefulWidget {
  const DownloaderNotifierBar(
    this.data, {
    super.key,
    required this.parentContext,
    this.type = DownloaderNotifierType.float,
    this.borderRadius,
    this.thumbnail,
  });
  final BuildContext parentContext;
  final DownloaderNotifierType type;
  final DownloaderNotifierProgress data;
  final BorderRadius? borderRadius;
  final Widget? thumbnail;

  @override
  State<DownloaderNotifierBar> createState() => _DNBs();
}

class _DNBs extends State<DownloaderNotifierBar> {
  late ThemeData theme;
  late DownloaderNotifierController? controller;
  late DateTime latest;

  @override
  void initState() {
    super.initState();
    controller = DownloaderNotifierController.maybeOf(widget.parentContext);
    theme = Theme.of(widget.parentContext);
  }

  String get name {
    final name = widget.data.path.split('/').last;
    return name.isEmpty ? 'Downloading ...' : name;
  }

  double get progress {
    bool isLess = widget.data.progress < 0;
    bool isNaN = widget.data.progress.isNaN;
    bool isInvalid = (widget.data.progress / 100).isNaN;
    return isLess || isNaN || isInvalid ? 0 : widget.data.progress / 100;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(8.0),
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.01),
            foregroundDecoration: BoxDecoration(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(8.0),
              color: Colors.transparent,
              border: Border.all(
                width: 0.5,
                color: Color.lerp(theme.colorScheme.surface,
                        theme.colorScheme.onSurface, 0.1) ??
                    theme.colorScheme.onSurface,
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: widget.borderRadius ?? BorderRadius.circular(8.0),
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 0.5,
                    spreadRadius: 0.5,
                    color: theme.colorScheme.onSurface.withOpacity(0.25),
                  )
                ]),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(
                        MediaQuery.sizeOf(context).width * 0.025),
                    decoration: BoxDecoration(
                      borderRadius:
                          widget.borderRadius ?? BorderRadius.circular(8.0),
                      // color: theme.colorScheme.surface,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        widget.thumbnail ??
                            Stack(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.15,
                                  height:
                                      MediaQuery.sizeOf(context).width * 0.15,
                                  decoration: BoxDecoration(
                                      // color: Color.lerp(theme.colorScheme.surface,
                                      //     theme.colorScheme.onSurface, 0.1),
                                      color: theme.colorScheme.primary,
                                      borderRadius: widget.borderRadius ??
                                          BorderRadius.circular(8.0)),
                                  alignment: Alignment.center,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox.square(
                                        dimension:
                                            MediaQuery.sizeOf(context).width *
                                                0.1,
                                        child: CircularProgressIndicator(
                                          value: 1.0,
                                          strokeWidth: 1.5,
                                          color: theme.colorScheme.surface
                                              .withOpacity(0.1),
                                        ),
                                      ),
                                      SizedBox.square(
                                        dimension:
                                            MediaQuery.sizeOf(context).width *
                                                0.1,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1.5,
                                          color: theme.colorScheme.surface,
                                          value: progress,
                                        ),
                                      ),
                                      name.split('.').last.isNotEmpty
                                          ? Text(
                                              name
                                                  .split('.')
                                                  .last
                                                  .toUpperCase()
                                                  .padRight(3, ' ')
                                                  .substring(0, 3)
                                                  .trim(),
                                              maxLines: 1,
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    theme.colorScheme.surface,
                                              ),
                                            )
                                          : Icon(
                                              Icons.download,
                                              color: theme.colorScheme.surface,
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.sizeOf(context).width * 0.025),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  maxLines: 1,
                                ),
                                Stack(
                                  children: [
                                    Divider(
                                      color: Color.lerp(
                                          theme.colorScheme.surface,
                                          theme.colorScheme.onSurface,
                                          0.25),
                                    ),
                                    Divider(
                                      endIndent: progress >= 100
                                          ? null
                                          : MediaQuery.sizeOf(context).width -
                                              (MediaQuery.sizeOf(context)
                                                      .width *
                                                  progress),
                                      color: theme.colorScheme.primary,
                                    ),
                                  ],
                                ),
                                () {
                                  switch (widget.data.status) {
                                    case DownloadStatus.canceling:
                                      return const Text('Download Failed');
                                    case DownloadStatus.failed:
                                      return const Text('Download Canceled');
                                    case DownloadStatus.paused:
                                      return const Text('Download Paused');
                                    case DownloadStatus.pending:
                                      return const Text('0%');
                                    case DownloadStatus.running:
                                    case DownloadStatus.successful:
                                      return Text(
                                          '${(progress * 100).toInt()}%');
                                  }
                                }(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (widget.data.path.isNotEmpty &&
                    widget.data.status == DownloadStatus.successful)
                  FutureBuilder(
                    future: () async {
                      latest = DateTime.now();
                      await Future.delayed(controller?.onFinishDuration ??
                          const Duration(seconds: 5));
                      bool isLatest =
                          latest.difference(DateTime.now()).inSeconds.abs() >=
                              5;
                      if (isLatest) controller?.close();
                    }(),
                    builder: (context, _) {
                      return IntrinsicWidth(
                        child: Column(
                          children: [
                            for (int i = 0; i < 2; i++)
                              Expanded(
                                child: Material(
                                  borderRadius: BorderRadius.only(
                                    topRight: i == 0
                                        ? widget.borderRadius?.topRight ??
                                            const Radius.circular(8.0)
                                        : Radius.zero,
                                    bottomRight: i == 1
                                        ? widget.borderRadius?.bottomRight ??
                                            const Radius.circular(8.0)
                                        : Radius.zero,
                                  ),
                                  child: InkWell(
                                    highlightColor: theme.colorScheme.primary
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.only(
                                      topRight: i == 0
                                          ? widget.borderRadius?.topRight ??
                                              const Radius.circular(8.0)
                                          : Radius.zero,
                                      bottomRight: i == 1
                                          ? widget.borderRadius?.bottomRight ??
                                              const Radius.circular(8.0)
                                          : Radius.zero,
                                    ),
                                    onTap: () async {
                                      switch (i) {
                                        case 0:
                                          latest = DateTime.now();
                                          return await controller?.close();
                                        case 1:
                                          {
                                            if (widget.data.path.isNotEmpty) {
                                              try {
                                                await FlDownloader.openFile(
                                                    filePath: widget.data.path);
                                                latest = DateTime.now();
                                                return await controller
                                                    ?.close();
                                              } catch (e, s) {
                                                return controller?.onError
                                                    ?.call(e, s);
                                              }
                                            } else {
                                              return controller?.onError?.call(
                                                  'File path is empty', null);
                                            }
                                          }
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(
                                              MediaQuery.sizeOf(context).width *
                                                  0.025)
                                          .copyWith(
                                              top: i == 0
                                                  ? MediaQuery.sizeOf(context)
                                                          .width *
                                                      0.01
                                                  : 0,
                                              bottom: i == 1
                                                  ? MediaQuery.sizeOf(context)
                                                          .width *
                                                      0.01
                                                  : 0),
                                      child: Text(
                                        ['Close', 'Open'][i],
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: [
                                            theme.colorScheme.onSurface,
                                            theme.colorScheme.primary
                                          ][i],
                                          fontWeight: [
                                            FontWeight.normal,
                                            FontWeight.w600
                                          ][i],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
