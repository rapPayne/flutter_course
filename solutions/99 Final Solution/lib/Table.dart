import 'package:flutter/material.dart';
import 'seat.dart';

class Table extends StatelessWidget {
  final Map table;
  const Table({super.key, required this.table});

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
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(15))),
            child: Text(
              "${table["table_number"]}",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.background,
                  ),
            ),
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
