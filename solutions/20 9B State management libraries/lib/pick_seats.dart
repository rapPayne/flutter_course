import 'package:flutter/material.dart';
import 'package:raw_state/raw_state.dart';

class PickSeats extends StatefulWidget {
  const PickSeats({super.key});

  @override
  State<PickSeats> createState() => _PickSeatsState();
}

class _PickSeatsState extends State<PickSeats> {
  DateTime selectedDate = rawState.get<DateTime>("selectedDate");
  Map<String, dynamic> selectedShowing =
      rawState.get<Map<String, dynamic>>("selectedShowing");
  Map<String, dynamic> cart = rawState.get("cart");
  Map<String, dynamic> theater = rawState.get<Map<String, dynamic>>("theater");

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
