import 'package:broadcast_receiver/second_page.dart';
import 'package:broadcast_receiver/third_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_broadcast_receiver/flutter_broadcast_receiver.dart';
import 'package:get/get.dart';

import 'fourth_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      // print("BroadcastReceiver() data => $message");
      // Center(
      //   child: Text(
      //     message,
      //     style: TextStyle(
      //       color: Colors.black,
      //     ),
      //   ),
      // );
      final snackBar = SnackBar(
          content: Text(
        'A Broadcast is received\n_counter value is $message',
      ));
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

  // void _incrementCounter() {
  //   setState(() {

  //     Get.to(() => SecondPage());
  //   });
  //   //Publish broadcast
  //   // BroadcastReceiver().publish<String>("BROADCAST_RECEIVER_DEMO",
  //   //     arguments: _counter.toString());

  //   BroadcastReceiver()
  //       .publish<String>("BROADCAST_RECEIVER_DEMO", arguments: message);
  // }

  moveToPage() {
    if (dropdownValue == 'Custom broadcast receiver') {
      Get.to(() => const SecondPage());
    } else if (dropdownValue == 'Wifi RTT state change receiver') {
      Get.to(() => const ThirdPage());
    } else if (dropdownValue == 'System battery notification receiver') {
      Get.to(() => const FourthPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Broadcast Receiver'),
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
            ElevatedButton(
              onPressed: moveToPage,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
