import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_tiktok_events/tiktok_events.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _tiktokEventsPlugin = TiktokEvents();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              TextButton(
                  onPressed: () async {
                    await _tiktokEventsPlugin.init("123456", "123456", true);
                    if (kDebugMode) {
                      print("Init done");
                    }
                  },
                  child: const Text('Init')),
              TextButton(
                  onPressed: () async {
                    await _tiktokEventsPlugin.setIdentity(
                      userId: "123456",
                      userName: "John Doe",
                      email: "xxx@gmail.com",
                      phoneNumber: "1234567890",
                    );
                  },
                  child: const Text('Set Identity')),
              TextButton(
                  onPressed: () async {
                    await _tiktokEventsPlugin.logout();
                  },
                  child: const Text('Logout')),
            ],
          ),
        ),
      ),
    );
  }
}
