import 'dart:developer' as console;
import 'package:downloader_notifier/downloader_notifier.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    DownloaderNotifier.initialize(
      // onProgress: (queue) => console.log('Queue: $queue'),
      onError: (e, s) => console.log(e.toString(), stackTrace: s),
      app: const MaterialApp(
        home: MyApp(),
        title: 'Downloader Notifier',
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return Center(
          child: DownloaderNotifier.button(
              url:
                  'https://freetestdata.com/wp-content/uploads/2021/09/1-MB-DOC.doc',
              onError: (e, s) {
                ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                  SnackBar(
                    content: Text(e.toString()),
                  ),
                );
              },
              child: const Text('Download Test')),
        );
      }),
    );
  }
}
