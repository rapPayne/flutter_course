import 'package:flutter/material.dart';

class A2 extends StatefulWidget {
  const A2({super.key});

  @override
  State<A2> createState() => _A2State();
}

class _A2State extends State<A2> {
  String first = "Becky";
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("A2 $first"),
          TextField(
            onChanged: (val) => first = val,
            decoration: const InputDecoration(
              labelText: "First name",
            ),
            controller: _controller,
          ),
        ],
      ),
    );
  }
}
