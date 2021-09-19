import 'package:daam/state.dart';
import 'package:flutter/material.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text("Checkout"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.payment), onPressed: () => print('checking out')),
    );
  }
}
