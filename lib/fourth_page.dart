import 'package:flutter/material.dart';
import 'package:flutter_broadcast_receiver/flutter_broadcast_receiver.dart';
import 'package:get/get.dart';

import 'battery_percantage.dart';

class FourthPage extends StatefulWidget {
  const FourthPage({Key? key}) : super(key: key);

  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  void counter() {
    //Publish broadcast
    // BroadcastReceiver().publish<String>("BROADCAST_RECEIVER_DEMO",
    //     arguments: _counter.toString());
    BroadcastReceiver().subscribe<String>("BROADCAST_RECEIVER_DEMO",
        (String message) {
      // print("BroadcastReceiver() data => $message");
      Text(message);
      // final snackBar = SnackBar(content: Text('Initial broadcast $message'));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
    Get.to(() => BatteryPercantage(
          val: inputController.text,
        ));
    BroadcastReceiver().publish<String>("BROADCAST_RECEIVER_DEMO",
        arguments: inputController.text);
  }

  TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery Percentage'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(26.0),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: inputController,
            ),
          ),
          ElevatedButton(
            onPressed: counter,
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}
