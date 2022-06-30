import 'package:flutter/material.dart';
import 'package:flutter_broadcast_receiver/flutter_broadcast_receiver.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String message = "Hello";

  @override
  void initState() {
    super.initState();

    //Subscribe broadcast
    BroadcastReceiver().subscribe<String>("BROADCAST_RECEIVER_DEMO",
        (String message) {
      print("BroadcastReceiver() data => $message");
      final snackBar = SnackBar(content: Text('Initial broadcast $message'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
    BroadcastReceiver().publish<String>("Demo", arguments: message);
  }

  @override
  void dispose() {
    //Dispose broadcast
    BroadcastReceiver().unsubscribe("BROADCAST_RECEIVER_DEMO");
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    //Publish broadcast
    BroadcastReceiver().publish<String>("BROADCAST_RECEIVER_DEMO",
        arguments: _counter.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
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
