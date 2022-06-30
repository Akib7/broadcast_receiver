import 'package:broadcast_receiver/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_broadcast_receiver/flutter_broadcast_receiver.dart';
import 'package:get/get.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  void counter() {
    //Publish broadcast
    // BroadcastReceiver().publish<String>("BROADCAST_RECEIVER_DEMO",
    //     arguments: _counter.toString());
    BroadcastReceiver().subscribe<String>("BROADCAST_RECEIVER_DEMO",
        (String message) {
      print("BroadcastReceiver() data => $message");
      Text(message);
      // final snackBar = SnackBar(content: Text('Initial broadcast $message'));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
    Get.to(() => InputWidget());
    BroadcastReceiver().publish<String>("BROADCAST_RECEIVER_DEMO",
        arguments: inputController.text);
  }

  TextEditingController inputController = TextEditingController();

  // get retText {
  //   return inputController;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Column(children: [
        TextField(
          controller: inputController,
        ),
        ElevatedButton(
          onPressed: counter,
          child: const Text('Continue'),
        ),
      ]),
    );
  }
}
