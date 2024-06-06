import 'package:flutter/material.dart';
import 'seat.dart';

class Table extends StatelessWidget {
  const Table({
    super.key,
    required this.table,
    required this.usableWidth,
    required this.usableHeight,
  });
  final Map table;
  final double usableWidth;
  final double usableHeight;

  final double unscaledWidth = 100;
  final double unscaledHeight = 100;
  final double numberOfTablesPerRow = 5;
  final double numberOfRows = 3;
  final double maxSeatsPerTable = 4;

  @override
  Widget build(BuildContext context) {
    double scaleX = usableWidth / unscaledWidth;
    double scaleY = usableHeight / unscaledHeight;
    double widthOfSeat =
        scaleX * unscaledWidth / numberOfTablesPerRow / maxSeatsPerTable;
    print("widthOfSeat: $widthOfSeat");
    return Positioned(
      top: (table["row"] - 1) * (unscaledHeight / 3) * scaleY,
      left: (table["column"] - 1) * (unscaledWidth / 5) * scaleX,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: widthOfSeat * (table["seats"] as List).length,
            height: widthOfSeat,
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
            children: table["seats"]
                .map<Widget>(
                    (seat) => Seat(seat: seat, sizeOfSeat: widthOfSeat))
                .toList(),
          ),
        ],
      ),
    );
  }
}
