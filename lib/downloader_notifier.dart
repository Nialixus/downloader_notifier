library downloader_notifier;

import 'dart:async';
// import 'dart:collection';
// import 'dart:developer' as console;
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:fl_downloader/fl_downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_in_app_pip/flutter_in_app_pip.dart';

export 'package:flutter_in_app_pip/flutter_in_app_pip.dart' show PIPViewCorner;
export 'package:fl_downloader/fl_downloader.dart'
    show DownloadStatus, StatusReason;

part 'src/controllers/downloader_notifier_controller.dart';
part 'src/models/downloader_notifier_progress.dart';
part 'src/views/downloader_notifier_bar.dart';
part 'src/views/downloader_notifier_initializer.dart';
part 'src/views/downloader_notifier_page.dart';
part 'src/views/downloader_notifier_button.dart';

abstract class DownloaderNotifier {
  static DownloaderNotifierInitializer initialize({
    Key? key,
    void Function(List<DownloaderNotifierProgress> queue)? onProgress,
    void Function(dynamic e, StackTrace? s)? onError,
    bool draggable = true,
    PIPViewCorner initialCorner = PIPViewCorner.bottomRight,
    Duration onFinishDuration = const Duration(seconds: 5),
    double? height,
    double? width,
    EdgeInsets? margin,
    required MaterialApp app,
  }) {
    return DownloaderNotifierInitializer(
      key: key,
      onProgress: onProgress,
      onError: onError,
      app: app,
      draggable: draggable,
      initialCorner: initialCorner,
      height: height,
      margin: margin,
      onFinishDuration: onFinishDuration,
      width: width,
    );
  }

  static DownloaderNotifierButton button({
    Key? key,
    void Function(dynamic e, StackTrace? s)? onError,
    required String url,
    required Widget child,
  }) {
    return DownloaderNotifierButton(
      key: key,
      onError: onError,
      url: url,
      child: child,
    );
  }
}
