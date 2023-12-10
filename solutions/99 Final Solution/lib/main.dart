import 'package:daam/state/customer.dart';
import 'package:flutter/material.dart';
import 'checkout.dart';
import 'film_details.dart';
import 'landing.dart';
import 'pick_seats.dart';
import 'ticket.dart';
// import 'state/superState.dart';
// import 'state/app_state.dart';

import './state/global.dart';

void main() {
  global.set("selectedDate", DateTime.now());
  global.set("cart", <Map<String, dynamic>>[]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Customer customer = Customer()..email = "rap@creator.net";
    global.set("customer", customer);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reservations - Dinner And A Movie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (ctx) => const Landing(),
        "/film": (ctx) => const FilmDetails(),
        "/pickseats": (ctx) => const PickSeats(),
        "/checkout": (ctx) => const Checkout(),
        "/ticket": (ctx) => const Ticket(),
      },
    );
  }
}
