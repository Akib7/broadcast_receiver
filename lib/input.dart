import 'package:flutter/material.dart';

import 'second_page.dart';

class InputWidget extends StatelessWidget {
  InputWidget({Key? key}) : super(key: key);

  TextEditingController text = TextEditingController();
  SecondPage sPage = const SecondPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Page'),
      ),
      body: Column(
        children: const [
          Text(''),
        ],
      ),
    );
  }
}
