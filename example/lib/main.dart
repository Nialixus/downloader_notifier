import 'dart:developer' as console;
import 'package:downloader_notifier/downloader_notifier.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    DownloaderNotifier.initialize(
      // onProgress: (queue) => console.log('Queue: $queue'),
      onError: (e, s) => console.log(e.toString()),
      app: const MaterialApp(
        title: 'Downloader Notifier',
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (x) => Center(
          child: Material(
            color: Colors.blue,
            child: DownloaderNotifier.button(
              url:
                  'https://freetestdata.com/wp-content/uploads/2022/11/Free_Test_Data_10.5MB_PDF.pdf',
              onError: (e, s) {
                ScaffoldMessenger.maybeOf(x)?.showSnackBar(
                  SnackBar(
                    content: Text('$e'),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text(
                  'Download',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
