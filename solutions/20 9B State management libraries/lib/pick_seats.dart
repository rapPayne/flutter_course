import 'package:daam/state/global.dart';
import 'package:flutter/material.dart';

class PickSeats extends StatefulWidget {
  const PickSeats({super.key});

  @override
  State<PickSeats> createState() => _PickSeatsState();
}

class _PickSeatsState extends State<PickSeats> {
  DateTime selectedDate = global.get<DateTime>("selectedDate");
  Map<String, dynamic> selectedShowing =
      global.get<Map<String, dynamic>>("selectedShowing");
  Map<String, dynamic> theater = global.get<Map<String, dynamic>>("theater");

  @override
  Widget build(BuildContext context) {
    print(selectedDate);
    print(selectedShowing);
    print(theater);
    return Column(
      children: [
        const Text("PickSeats"),
        FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, "/checkout"))
      ],
    );
  }
}
