import 'package:broadcast_receiver/second_page.dart';
import 'package:broadcast_receiver/third_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_broadcast_receiver/flutter_broadcast_receiver.dart';
import 'package:get/get.dart';

import 'fourth_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
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

  String dropdownValue = 'Custom broadcast receiver';
  String holder = '';
  List<String> name = [
    'Custom broadcast receiver',
    'Wifi RTT state change receiver',
    'System battery notification receiver',
  ];

  // void getDropDownItem() {
  //   setState(() {
  //     holder = dropdownValue;
  //   });
  // }

  @override
  void initState() {
    super.initState();

    //Subscribe broadcast
    BroadcastReceiver().subscribe<String>("BROADCAST_RECEIVER_DEMO",
        (String message) {
      print("BroadcastReceiver() data => $message");
      Text(message);
      // final snackBar = SnackBar(content: Text('Initial broadcast $message'));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
      Get.to(() => SecondPage());
    });
    //Publish broadcast
    // BroadcastReceiver().publish<String>("BROADCAST_RECEIVER_DEMO",
    //     arguments: _counter.toString());

    BroadcastReceiver()
        .publish<String>("BROADCAST_RECEIVER_DEMO", arguments: message);
  }

  moveToPage() {
    if (dropdownValue == 'Custom broadcast receiver') {
      Get.to(() => SecondPage());
    } else if (dropdownValue == 'Wifi RTT state change receiver') {
      Get.to(() => ThirdPage());
    } else if (dropdownValue == 'System battery notification receiver') {
      Get.to(() => const FourthPage());
    }
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
            DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
              underline: Container(
                height: 0,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });

                // if (dropdownValue == 'Custom broadcast receiver') {
                //   Get.to(() => const SecondPage());
                // }
              },
              items: name.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              // selectedItemBuilder: ,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              onPressed: moveToPage,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
