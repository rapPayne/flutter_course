// ignore: unused_import
import 'package:daam/checkout.dart';
import 'package:daam/film_details.dart';
// ignore: unused_import
import 'package:daam/landing.dart';
import 'package:daam/pick_seats.dart';
import 'package:daam/state/global.dart';
import 'package:daam/ticket.dart';
import 'package:flutter/material.dart';

void main() {
  global.set("selectedDate", DateTime.now()); // <-- Add this line
  global.set("cart", <String, dynamic>{"seats": []}); // <-- And this one
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: true,
        child: MaterialApp(
          title: 'Dinner and a Movie',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: "/",
          routes: {
            "/": (ctx) => const Landing(),
            "/film": (ctx) => const FilmDetails(),
            "/pickseats": (ctx) => const PickSeats(),
            "/checkout": (ctx) => const Checkout(),
            "/ticket": (ctx) => const Ticket(),
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
