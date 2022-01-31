import 'package:flutter/material.dart';

void main() => runApp(const NoteApp());

class NoteApp extends StatelessWidget {
  const NoteApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const NoteHomePage(title: 'Note Module'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NoteHomePage extends StatefulWidget {
  const NoteHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<NoteHomePage> createState() => _NoteHomePageState();
}

class _NoteHomePageState extends State<NoteHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
