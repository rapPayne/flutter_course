import 'package:flutter/material.dart';
import 'package:raw_state/raw_state.dart';
import 'package:daam/state/seat_status.dart';

class TheaterTable extends StatelessWidget {
  const TheaterTable({
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
    return Positioned(
      top: (table['row'] - 1) * (unscaledHeight / 3) * scaleY,
      left: (table['column'] - 1) * (unscaledWidth / 5) * scaleX,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: widthOfSeat * (table['seats'] as List).length,
            height: widthOfSeat,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(15))),
            child: Text(
              "${table['table_number']}",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.background,
                  ),
            ),
          ),
          Row(
            children: table['seats']
                .map<Widget>(
                    (seat) => Seat(seat: seat, sizeOfSeat: widthOfSeat))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class Seat extends StatefulWidget {
  const Seat({super.key, required this.seat, this.sizeOfSeat = 30.0});
  final Map<String, dynamic> seat;
  final double sizeOfSeat;

  @override
  State<Seat> createState() => _SeatState();
}

class _SeatState extends State<Seat> {
  Color _seatColor = Colors.blue;
  final Map<String, dynamic> _selectedShowing =
      rawState.get<Map<String, dynamic>>('selectedShowing');

  @override
  Widget build(BuildContext context) {
    switch (widget.seat['status']) {
      case SeatStatus.reserved:
        _seatColor = Colors.grey;
        break;
      case SeatStatus.inCart:
        _seatColor = Colors.red;
        break;
      default:
        _seatColor = Colors.blue;
    }
    return GestureDetector(
      child: SizedBox(
        width: widget.sizeOfSeat,
        height: widget.sizeOfSeat,
        child: Stack(alignment: Alignment.center, children: [
          Icon(
            Icons.weekend_rounded,
            color: _seatColor,
            size: widget.sizeOfSeat,
          ),
          Text(widget.seat['seat_number'].toString()),
        ]),
      ),
      onTap: () {
        Map<String, dynamic> cart = rawState.get<Map<String, dynamic>>('cart');
        cart['showing_id'] = _selectedShowing['id'];
        switch (widget.seat['status']) {
          case SeatStatus.reserved:
            return;
          case SeatStatus.inCart:
            cart['seats'] = cart['seats']
                .where((item) => item['id'] != widget.seat['id'])
                .toList();
            setState(() {
              widget.seat['status'] = SeatStatus.available;
            });
            break;
          case SeatStatus.available:
            cart['seats'].add({
              ...widget.seat,
              'showingId': _selectedShowing['id'],
            }..remove('status'));
            setState(() {
              widget.seat['status'] = SeatStatus.inCart;
            });
            break;
          default:
            throw Exception(
                "Bad SeatStatus in Seat widget: ${widget.seat['status']}.");
        }
        rawState.set('cart', cart);
      },
    );
  }
}
