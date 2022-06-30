import 'package:flutter/material.dart';
import 'dart:io';

class ThirdPage extends StatelessWidget {
  ThirdPage({Key? key}) : super(key: key);
  var text;
  Future<Widget> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        text = Text('connected');
      }
    } on SocketException catch (_) {
      text = Text('not connected');
    }
    return text;
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
