import 'package:daam/state/customer.dart';
import 'package:flutter/material.dart';
import 'package:raw_state/raw_state.dart';
import 'checkout.dart';
import 'film_details.dart';
import 'landing.dart';
import 'pick_seats.dart';
import 'ticket.dart';

void main() {
  rawState.set("selectedDate", DateTime.now()); // <-- Add this line
  rawState.set("cart", <String, dynamic>{"seats": []}); // <-- And this one
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
    ).copyWith(background: Colors.white);

    var themeData = ThemeData(
      colorScheme: colorScheme,
      textTheme: const TextTheme(titleMedium: TextStyle(color: Colors.blue)),
      useMaterial3: true,
    );
    Customer customer = Customer()..email = "rap@creator.net";
    rawState.set("customer", customer);
    return OurThemeWidget(
      child: MaterialApp(
        theme: themeData,
        debugShowCheckedModeBanner: false,
        title: 'Reservations - Dinner And A Movie',
        initialRoute: "/",
        routes: {
          "/": (ctx) => const Landing(),
          "/film": (ctx) => const FilmDetails(),
          "/pickseats": (ctx) => const PickSeats(),
          "/checkout": (ctx) => const Checkout(),
          "/ticket": (ctx) => const Ticket(),
        },
      ),
    );
  }
}

class OurThemeWidget extends StatelessWidget {
  const OurThemeWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return
        // Theme(
        //   data:
        //   child:
        child;
  }
}
