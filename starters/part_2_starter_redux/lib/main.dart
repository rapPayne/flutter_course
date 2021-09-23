import 'package:flutter/material.dart';
// import 'Checkout.dart';
import 'FilmDetails.dart';
import 'Landing.dart';
import 'PickSeats.dart';
// import 'Ticket.dart';
import 'store/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'store/AppState.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*
    The StoreProvider provides the store to all ancestors who need it, namely StoreConnectors. They look up in the heirarchy until they find this guy. One StoreProvider to many StoreConnectors.
    */
    return StoreProvider<AppState>(
      store: store,
      /*
        This StoreConnector says to redraw this any time a dispatch is called from any descendant.
        */
      child: StoreConnector<AppState, AppState>(
        converter: (store) {
          return store.state;
        },
        builder: (context, callback) {
          print('building');
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routes: {
              "/": (_) => Landing(),
              "/details": (_) => FilmDetails(),
              "/pickseats": (_) => PickSeats(),
              // "/checkout": (_) => Checkout(),
              // "/tickets": (_) => Ticket(),
            },
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    ); // <-- ... and this
  }
}
