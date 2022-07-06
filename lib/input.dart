import 'package:flutter/material.dart';

import 'second_page.dart';

// ignore: must_be_immutable
class InputWidget extends StatelessWidget {
  final String val;
  InputWidget({Key? key, required this.val}) : super(key: key);

  TextEditingController text = TextEditingController();
  SecondPage sPage = const SecondPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              val,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
