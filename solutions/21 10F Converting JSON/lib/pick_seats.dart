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
  Map<String, dynamic> cart = global.get("cart");
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
          onPressed: () {
            // For debugging only - Load the cart up with data
            cart = {
              "showing_id": 100,
              "seats": [7, 8, 10, 22],
              "user_id": 10,
              "first_name": "Jo",
              "last_name": "Smith",
              "email": "jo.smith@gmail.com",
              "phone": "555-555-1234",
              "pan": "6011-0087-7345-4323",
              "expiry_month": 1,
              "expiry_year": 2025,
              "cvv": 123
            };
            Navigator.pushNamed(context, "/checkout");
          },
        )
      ],
    );
  }
}
