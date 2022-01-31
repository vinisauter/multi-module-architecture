import 'package:flutter/material.dart';

void main() => runApp(const TaskApp());

class TaskApp extends StatelessWidget {
  const TaskApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const TaskHomePage(title: 'Task Module'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TaskHomePage extends StatefulWidget {
  const TaskHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TaskHomePage> createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
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
