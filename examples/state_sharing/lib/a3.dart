import 'package:flutter/material.dart';

class A3 extends StatefulWidget {
  const A3({super.key});

  @override
  State<A3> createState() => _A3State();
}

class _A3State extends State<A3> {
  String first = "Becky";
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("A3 $first"),
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
