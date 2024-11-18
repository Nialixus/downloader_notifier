part of '../../downloader_notifier.dart';

class DownloaderNotifierInitializer extends StatefulWidget {
  const DownloaderNotifierInitializer({
    super.key,
    this.onError,
    this.onProgress,
    this.onFinishDuration = const Duration(seconds: 5),
    this.margin,
    this.width,
    this.height,
    this.draggable = true,
    this.alignment = DownloaderNotifierAlignment.bottomRight,
    required this.app,
  }) : _isRouter = false;

  const DownloaderNotifierInitializer.router({
    super.key,
    this.onError,
    this.onProgress,
    this.onFinishDuration = const Duration(seconds: 5),
    this.margin,
    this.width,
    this.height,
    this.draggable = true,
    this.alignment = DownloaderNotifierAlignment.bottomRight,
    required this.app,
  }) : _isRouter = true;

  final Duration onFinishDuration;
  final void Function(List<DownloaderNotifierProgress> queue)? onProgress;
  final void Function(dynamic e, StackTrace? s)? onError;
  final MaterialApp app;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final bool draggable;
  final DownloaderNotifierAlignment alignment;
  final bool _isRouter;

  @override
  State<DownloaderNotifierInitializer> createState() => _DNIs();
}

class _DNIs extends State<DownloaderNotifierInitializer> {
  StreamSubscription<DownloadProgress>? stream;
  List<DownloaderNotifierProgress> _queue = [];

  List<DownloaderNotifierProgress> get queue {
    return {for (var item in _queue) item.id: item}.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onProgress?.call(queue);
    });

    return DownloaderNotifierController(
      queue: queue,
      onFinishDuration: widget.onFinishDuration,
      onError: widget.onError,
      child: () {
        final param = PiPParams(
          initialCorner: PIPViewCorner.values[widget.alignment.index],
          // resizable: true,
          bottomSpace:
              widget.margin?.bottom ?? MediaQuery.sizeOf(context).width * 0.05,
          leftSpace:
              widget.margin?.left ?? MediaQuery.sizeOf(context).width * 0.05,
          rightSpace:
              widget.margin?.right ?? MediaQuery.sizeOf(context).width * 0.05,
          topSpace:
              widget.margin?.top ?? MediaQuery.sizeOf(context).width * 0.05,
          pipWindowHeight:
              widget.height ?? MediaQuery.sizeOf(context).width * 0.225,
          pipWindowWidth:
              widget.width ?? MediaQuery.sizeOf(context).width * 0.9,
          minSize: Size(
              widget.width ?? MediaQuery.sizeOf(context).width * 0.225,
              widget.height ?? MediaQuery.sizeOf(context).width * 0.9),
          maxSize: Size(
              widget.width ?? MediaQuery.sizeOf(context).width * 0.225,
              widget.height ?? MediaQuery.sizeOf(context).width * 0.9),
          movable: widget.draggable,
        );
        switch (widget._isRouter) {
          case true:
            return PopScope(
              canPop: false,
              child: PiPMaterialApp.router(
                pipParams: param,
                key: widget.app.key,
                title: widget.app.title,
                actions: widget.app.actions,
                checkerboardOffscreenLayers:
                    widget.app.checkerboardOffscreenLayers,
                checkerboardRasterCacheImages:
                    widget.app.checkerboardRasterCacheImages,
                showPerformanceOverlay: widget.app.showPerformanceOverlay,
                debugShowMaterialGrid: widget.app.debugShowMaterialGrid,
                debugShowCheckedModeBanner:
                    widget.app.debugShowCheckedModeBanner,
                color: widget.app.color,
                locale: widget.app.locale,
                localizationsDelegates: widget.app.localizationsDelegates,
                localeListResolutionCallback:
                    widget.app.localeListResolutionCallback,
                localeResolutionCallback: widget.app.localeResolutionCallback,
                supportedLocales: widget.app.supportedLocales,
                builder: widget.app.builder,
                onGenerateTitle: widget.app.onGenerateTitle,
                darkTheme: widget.app.darkTheme,
                highContrastDarkTheme: widget.app.highContrastDarkTheme,
                highContrastTheme: widget.app.highContrastTheme,
                theme: widget.app.theme,
                themeMode: widget.app.themeMode,
                onNavigationNotification: widget.app.onNavigationNotification,
                restorationScopeId: widget.app.restorationScopeId,
                scaffoldMessengerKey: widget.app.scaffoldMessengerKey,
                scrollBehavior: widget.app.scrollBehavior,
                shortcuts: widget.app.shortcuts,
                showSemanticsDebugger: widget.app.showSemanticsDebugger,
                themeAnimationCurve: widget.app.themeAnimationCurve,
                themeAnimationDuration: widget.app.themeAnimationDuration,
                themeAnimationStyle: widget.app.themeAnimationStyle,
                // ignore: deprecated_member_use
                useInheritedMediaQuery: widget.app.useInheritedMediaQuery,
                backButtonDispatcher: widget.app.backButtonDispatcher,
                routeInformationParser: widget.app.routeInformationParser,
                routeInformationProvider: widget.app.routeInformationProvider,
                routerConfig: widget.app.routerConfig,
                routerDelegate: widget.app.routerDelegate,
              ),
            );
          case false:
            return PopScope(
              canPop: false,
              child: PiPMaterialApp(
                pipParams: param,
                key: widget.app.key,
                home: widget.app.home,
                title: widget.app.title,
                actions: widget.app.actions,
                checkerboardOffscreenLayers:
                    widget.app.checkerboardOffscreenLayers,
                checkerboardRasterCacheImages:
                    widget.app.checkerboardRasterCacheImages,
                showPerformanceOverlay: widget.app.showPerformanceOverlay,
                debugShowMaterialGrid: widget.app.debugShowMaterialGrid,
                debugShowCheckedModeBanner:
                    widget.app.debugShowCheckedModeBanner,
                color: widget.app.color,
                navigatorObservers: widget.app.navigatorObservers ??
                    const <NavigatorObserver>[],
                locale: widget.app.locale,
                localizationsDelegates: widget.app.localizationsDelegates,
                localeListResolutionCallback:
                    widget.app.localeListResolutionCallback,
                localeResolutionCallback: widget.app.localeResolutionCallback,
                supportedLocales: widget.app.supportedLocales,
                onGenerateRoute: widget.app.onGenerateRoute,
                onUnknownRoute: widget.app.onUnknownRoute,
                navigatorKey: widget.app.navigatorKey,
                onGenerateInitialRoutes: widget.app.onGenerateInitialRoutes,
                builder: widget.app.builder,
                onGenerateTitle: widget.app.onGenerateTitle,
                darkTheme: widget.app.darkTheme,
                highContrastDarkTheme: widget.app.highContrastDarkTheme,
                highContrastTheme: widget.app.highContrastTheme,
                theme: widget.app.theme,
                themeMode: widget.app.themeMode,
                initialRoute: widget.app.initialRoute,
                onNavigationNotification: widget.app.onNavigationNotification,
                restorationScopeId: widget.app.restorationScopeId,
                routes: <String, WidgetBuilder>{
                  for (var item in widget.app.routes?.entries ?? {}.entries)
                    item.key: item.value
                },
                scaffoldMessengerKey: widget.app.scaffoldMessengerKey,
                scrollBehavior: widget.app.scrollBehavior,
                shortcuts: widget.app.shortcuts,
                showSemanticsDebugger: widget.app.showSemanticsDebugger,
                themeAnimationCurve: widget.app.themeAnimationCurve,
                themeAnimationDuration: widget.app.themeAnimationDuration,
                themeAnimationStyle: widget.app.themeAnimationStyle,
                // ignore: deprecated_member_use
                useInheritedMediaQuery: widget.app.useInheritedMediaQuery,
              ),
            );
        }
      }(),
    );
  }

  Future<void> initialize() async {
    try {
      await FlDownloader.initialize();
      await stream?.cancel();
      stream = FlDownloader.progressStream.listen(
        (event) async {
          try {
            setState(() => _queue = [
                  ..._queue,
                  DownloaderNotifierProgress.migrate(event)
                ]);
            await Future.delayed(const Duration(milliseconds: 10));
            if (queue.any((where) => where.status == DownloadStatus.running)) {
              PictureInPicture.startPiP(
                pipWidget: NavigatablePiPWidget(
                  pipBorderRadius: 8.0,
                  elevation: 0.0,
                  onPiPClose: () {},
                  builder: (_) {
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
          } catch (e, s) {
            widget.onError?.call(e, s);
          }
        },
        onError: (e) {
          widget.onError?.call(e, null);
        },
      );
    } catch (e, s) {
      widget.onError?.call(e, s);
    }
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    stream?.cancel();
    super.dispose();
  }
}
