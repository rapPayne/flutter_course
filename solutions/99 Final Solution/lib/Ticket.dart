import 'package:flutter/material.dart';

class Ticket extends StatefulWidget {
  const Ticket({super.key});

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Ticket"),
        ),
        // ignore: avoid_unnecessary_containers
        body: Container(
          child: const Text("Ticket"),
        ));
  }
}
