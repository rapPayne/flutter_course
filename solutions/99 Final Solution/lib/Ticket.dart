import 'package:daam/state/global.dart';
import 'package:flutter/material.dart';

class Ticket extends StatefulWidget {
  const Ticket({super.key});

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  List<Map<String, dynamic>> tickets = global.get("tickets");
  @override
  Widget build(BuildContext context) {
    print("tix $tickets");

    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Ticket"),
        ),
        // ignore: avoid_unnecessary_containers
        body: Container(
          child: Column(
            children: [
              ...tickets.map((t) => makeTicket(t)).toList(),
              ElevatedButton(
                onPressed: () =>
                    Navigator.popUntil(context, ModalRoute.withName('/')),
                child: const Text("Finished"),
              ),
            ],
          ),
        ));
  }

  Widget makeTicket(Map<String, dynamic> ticket) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2.0,
        ),
      ),
      child: Column(
        children: [
          Text(ticket["id"].toString()),
          Text(ticket["showing_id"].toString()),
          Text(ticket["seat_id"].toString()),
        ],
      ),
    );
  }
}
