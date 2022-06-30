import 'package:flutter/material.dart';
import 'dart:io';

class ThirdPage extends StatelessWidget {
  const ThirdPage({Key? key}) : super(key: key);

  checkInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<Widget>(
              future: checkInternet(),
              builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                return Container(child: CircularProgressIndicator());
              }),
        ],
      ),
    );
  }
}
