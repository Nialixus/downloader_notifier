part of '../../downloader_notifier.dart';

class DownloaderNotifierProgress {
  const DownloaderNotifierProgress({
    required this.id,
    required this.path,
    required this.progress,
    required this.status,
    required this.description,
  });

  final String id;
  final String path;
  final int progress;
  final DownloadStatus status;
  final StatusReason description;

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'path': path,
      'progress': progress,
      'status': status.index,
      'description': {
        'code': description.code,
        'type': description.type,
        'message': description.message,
      },
    };
  }

  static DownloaderNotifierProgress fromJSON(Map<String, dynamic> value) {
    Map<String, dynamic> desc = value['description'] is Map<String, dynamic>
        ? value['description'] as Map<String, dynamic>
        : <String, dynamic>{};
    return DownloaderNotifierProgress(
      id: value['id']?.toString() ?? '',
      path: value['path']?.toString() ?? '',
      progress: int.tryParse((value['progress']?.toString() ?? '0')) ?? 0,
      status: DownloadStatus.values[
          (int.tryParse(value['status']?.toString() ?? '5') ?? 5) %
              DownloadStatus.values.length],
      description: StatusReason(
        code: int.tryParse(desc['code']?.toString() ?? '-1') ?? -1,
        type: desc['type']?.toString() ?? "NULL",
        message: desc['message']?.toString() ?? "No reason available",
      ),
    );
  }

  static DownloaderNotifierProgress migrate(DownloadProgress value) {
    return DownloaderNotifierProgress(
      id: value.downloadId?.toString() ?? '',
      progress: value.progress,
      status: value.status,
      path: value.filePath ?? '',
      description: value.statusReason ??
          StatusReason(
            code: -1,
            type: 'NULL',
            message: 'No reason available',
          ),
    );
  }

  factory DownloaderNotifierProgress.test({bool random = true}) {
    switch (random) {
      case true:
        final math = Random();
        return DownloaderNotifierProgress(
          id: math.nextInt(100).toString(),
          progress: math.nextInt(100),
          status:
              DownloadStatus.values[math.nextInt(DownloadStatus.values.length)],
          path: '/${math.nextInt(100)}',
          description: StatusReason(
            code: math.nextInt(100),
            type: [
              'ANDROID_ERROR',
              'IOS_ERROR',
              'WINDOWS_ERROR',
              'HTTP_ERROR',
              'ANDROID'
            ][math.nextInt(5)],
            message:
                '${DownloadStatus.values[math.nextInt(DownloadStatus.values.length)]}',
          ),
        );
      case false:
        return DownloaderNotifierProgress(
          id: '',
          path: '',
          progress: 0,
          status: DownloadStatus.pending,
          description: StatusReason(
            code: -1,
            type: 'NULL',
            message: 'No reason available',
          ),
        );
    }
  }

  @override
  String toString() {
    return '$runtimeType(id: $id, '
        'progress: $progress, '
        'status: $status, '
        'path: $path, '
        'description: StatusReason('
        'code: ${description.code}, '
        'type: ${description.type}, '
        'message: ${description.message}))';
  }
}
