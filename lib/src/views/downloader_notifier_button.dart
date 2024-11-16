// ignore_for_file: use_build_context_synchronously

part of '../../downloader_notifier.dart';

class DownloaderNotifierButton extends StatelessWidget {
  const DownloaderNotifierButton({
    super.key,
    this.onError,
    required this.url,
    required this.child,
  });
  final void Function(dynamic e, StackTrace? s)? onError;
  final String url;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => DownloaderNotifierController.maybeOf(context)?.open(
        context,
        onError: onError,
        url: url,
      ),
      child: child,
    );
  }
}
