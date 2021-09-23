import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'state.dart';
import 'Film.dart';
import 'Checkout.dart';
import 'FilmDetails.dart';
import 'Landing.dart';
import 'PickSeats.dart';
import 'Ticket.dart';

void main() => runApp(ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      // <-- Add this ...
      var films = watch(filmsProvider).state; // <-- ... and this ...
      var showings = watch(showingsProvider).state; // <-- ... and this ...

      return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            "/": (_) => Landing(),
            "/details": (_) => FilmDetails(),
            "/pickseats": (_) => PickSeats(),
            "/checkout": (_) => Checkout(),
            "/tickets": (_) => Ticket(),
          });
    }); // <-- ... and this
  }
}
