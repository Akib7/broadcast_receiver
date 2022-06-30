import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Page'),
      ),
      body: Column(
        children: const [
          Text('data'),
        ],
      ),
    );
  }
}
