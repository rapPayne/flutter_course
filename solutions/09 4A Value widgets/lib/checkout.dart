import 'package:flutter/material.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Column(
        children: [
          Text("Checkout"),
          Text("Cart will go here"),
          Text("Form will go here"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.payment),
        onPressed: () => print("You pressed the FAB"),
      ),
    );
  }
}
