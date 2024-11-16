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
        builder: (context) {
          return Center(
            child: Material(
              color: Colors.blue,
              child: DownloaderNotifier.button(
                url:
                    'https://freetestdata.com/wp-content/uploads/2021/09/Free_Test_Data_1MB_PDF.pdf',
                onError: (e, s) {
                  ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
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
          );
        },
      ),
    );
  }
}
