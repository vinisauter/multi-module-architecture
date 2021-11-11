// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

void main() => runApp(const ProfileApp(color: Colors.orange));

class ProfileApp extends StatelessWidget {
  const ProfileApp({Key? key, required this.color}) : super(key: key);

  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfil e Configurações',
      theme: ThemeData(
        primarySwatch: color,
      ),
      home: const Profile(title: 'Perfil e Configurações'),
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int? _counter = 0;
  late MethodChannel _channel;

  @override
  void initState() {
    super.initState();
    _channel = const MethodChannel('multiple-flutters');
    _channel.setMethodCallHandler((call) async {
      if (call.method == "setCount") {
        // A notification that the host platform's data model has been updated.
        setState(() {
          _counter = call.arguments as int?;
        });
      } else {
        throw Exception('not implemented ${call.method}');
      }
    });
  }

  void _incrementCounter() {
    // Mutations to the data model are forwarded to the host platform.
    _channel.invokeMethod<void>("incrementCount", _counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextButton(
              onPressed: _incrementCounter,
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                _channel.invokeMethod<void>("next", _counter);
              },
              child: const Text('Next'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Use the url_launcher plugin to open the Flutter docs in
                // a browser.
                const url = 'https://flutter.dev/docs';
                if (await launcher.canLaunch(url)) {
                  launcher.launch(url);
                }
              },
              child: const Text('Open Flutter Docs'),
            ),
          ],
        ),
      ),
    );
  }
}
