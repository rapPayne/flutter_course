import 'package:flutter/material.dart';
import 'seat.dart';

class Table extends StatelessWidget {
  final Map table;
  const Table({Key? key, required Map this.table}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: (table["row"] - 1) * 100.0,
      left: (table["column"] - 1) * 130.0,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: 30.0 * (table["seats"] as List).length,
            height: 30.0,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Text("Table ${table["table_number"]}"),
          ),
          Row(
            children:
                table["seats"].map<Widget>((seat) => Seat(seat: seat)).toList(),
          ),
        ],
      ),
    );
  }
}
