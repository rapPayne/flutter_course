import 'package:flutter/material.dart';

class PickSeats extends StatefulWidget {
  const PickSeats({super.key});

  @override
  State<PickSeats> createState() => _PickSeatsState();
}

class _PickSeatsState extends State<PickSeats> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("PickSeats"),
        FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, "/checkout"))
      ],
    );
  }
}
