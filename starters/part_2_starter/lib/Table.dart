import 'package:flutter/material.dart';
import 'Seat.dart';

class Table extends StatelessWidget {
  const Table({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Table"),
        Seat(),
      ],
    );
  }
}
