import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

class BatteryPercantage extends StatefulWidget {
  final String val;
  const BatteryPercantage({
    Key? key,
    required this.val,
  }) : super(key: key);

  @override
  State<BatteryPercantage> createState() => _BatteryPercantageState();
}

class _BatteryPercantageState extends State<BatteryPercantage> {
  var battery = Battery();
  int percentage = 0;
  late Timer timer;

  // created a Batterystate of enum type
  BatteryState batteryState = BatteryState.full;
  late StreamSubscription streamSubscription;

  @override
  void initState() {
    super.initState();
    // calling the method to get battery state
    getBatteryState();

    // calling the method to get battery percentage
    Timer.periodic(const Duration(seconds: 5), (timer) {
      getBatteryPercentage();
    });
  }

  // method created to display battery percent
  void getBatteryPercentage() async {
    final level = await battery.batteryLevel;
    percentage = level;

    setState(() {});
  }

  // method to know the state of the battery
  void getBatteryState() {
    streamSubscription = battery.onBatteryStateChanged.listen((state) {
      batteryState = state;

      setState(() {});
    });
  }

// ignore: non_constant_identifier_names
  Widget BatteryBuild(BatteryState state) {
    switch (state) {
      case BatteryState.full:
        // ignore: sized_box_for_whitespace
        return Container(
          width: 200,
          height: 200,
          child: (const Icon(
            Icons.battery_full,
            size: 200,
            color: Colors.blue,
          )),
        );

      case BatteryState.charging:

        // ignore: sized_box_for_whitespace
        return Container(
          width: 200,
          height: 200,
          child: (const Icon(
            Icons.battery_charging_full,
            size: 200,
            color: Colors.blue,
          )),
        );

      case BatteryState.discharging:
      default:

        // ignore: sized_box_for_whitespace
        return Container(
          width: 200,
          height: 200,
          child: (const Icon(
            Icons.battery_full,
            size: 200,
            color: Colors.red,
          )),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Battery Percantage',
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // calling the custom widget
            BatteryBuild(batteryState),

            // Displaying battery percentage
            Text(
              'Battery Percentage: $percentage',
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              'User Typed the Battery Percentage: ${widget.val}',
              style: const TextStyle(fontSize: 24),
            )
          ],
        ),
      ),
    );
  }
}
