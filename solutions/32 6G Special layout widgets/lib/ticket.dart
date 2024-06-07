import 'dart:convert';
import 'package:daam/state/repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:raw_state/raw_state.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Ticket extends StatefulWidget {
  const Ticket({super.key});

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  List<Map<String, dynamic>> ticketNumbers =
      rawState.get<List<Map<String, dynamic>>>("ticketNumbers");
  List<Map<String, dynamic>> tickets = [];

  @override
  void initState() {
    super.initState();
    getReservations(ticketNumbers).then(
        (List<Map<String, dynamic>> tix) => setState(() => tickets = tix));
  }

  Future<List<Map<String, dynamic>>> getReservations(
      List<Map<String, dynamic>> ticketNumbers) async {
    List<Future<Map<String, dynamic>>> futures = [];
    for (var ticketNumber in ticketNumbers.map((t) => t['id'])) {
      Uri uri = Uri.parse('${getBaseUrl()}/api/reservations/$ticketNumber');
      futures.add(get(uri).then((res) => json.decode(res.body)));
    }
    return Future.wait(futures);
  }

  @override
  Widget build(BuildContext context) {
    print(ticketNumbers);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your tickets"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: tickets
              .map((t) => Column(children: [
                    const SizedBox(
                      height: 50.0,
                    ),
                    makeOneTicket(t)
                  ]))
              .toList(),
        ),
      ),
    );
  }

  Widget makeOneTicket(Map<String, dynamic> ticket) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 3.0),
          borderRadius: const BorderRadius.all(Radius.circular(20.0))),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const Text(
              "We're looking forward to seeing you. Show this to your host when you arrive. This is your ticket."),
          Text(ticket['film']['title'] ?? "(No title)"),
          Text(ticket['theater_name'] ?? "(No theater name)"),
          Text(ticket['showing']['showing_time'] ?? "(No date and time)"),
          Text(ticket['table_number']?.toString() ?? "(No table number)"),
          Text(ticket['seat']['seat_number']?.toString() ?? "(No seat number)"),
          Image.network("${getBaseUrl()}/${ticket['film']['poster_path']}"),
          Text(ticket['seat']['price']?.toString() ?? "(No price found)"),
          Text(ticket['id']?.toString() ?? "(No ticket number)"),
          QrImageView(data: ticket['id'].toString()),
        ],
      ),
    );
  }
}
