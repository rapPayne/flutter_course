import 'dart:math';

import 'package:flutter/material.dart';

class Overflows extends StatelessWidget {
  const Overflows({super.key});

  @override
  Widget build(BuildContext context) {
    //return _body;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overflows'),
      ),
      body: _body,
    );
  }

  Widget get _body {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _coloredBoxes(1000),
    );
  }

  List<Widget> _coloredBoxes(int howMany) {
    return List.generate(
        howMany,
        (index) => Container(
              color: Color(Random().nextInt(pow(2, 32).toInt())),
              child: Text(index.toString()),
            ));
  }
}
