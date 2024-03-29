import 'dart:math';

import 'package:flutter/material.dart';

class UnboundedHeight extends StatefulWidget {
  const UnboundedHeight({super.key});

  @override
  State<UnboundedHeight> createState() => _UnboundedHeightState();
}

class _UnboundedHeightState extends State<UnboundedHeight> {
  TextStyle? big;
  @override
  void didChangeDependencies() {
    big = Theme.of(context).textTheme.headlineLarge;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<Text> randomTexts = List.generate(
        80, (i) => Text("Random number: ${Random().nextInt(1000)}-$i"));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Some random strings for you", style: big),
        Expanded(
          child: ListView(
            children: randomTexts,
          ),
        ),
      ],
    );
  }
}
