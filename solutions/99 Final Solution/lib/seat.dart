import 'package:raw_state/raw_state.dart';
import 'package:daam/state/seat.dart';
import 'package:flutter/material.dart';

class Seat extends StatefulWidget {
  const Seat({super.key, required this.seat, this.sizeOfSeat = 30.0});
  final Map<String, dynamic> seat;
  final double sizeOfSeat;

  @override
  State<Seat> createState() => _SeatState();
}

class _SeatState extends State<Seat> {
  Color _seatColor = Colors.blue;
  final Map<String, dynamic> _cart = rawState.get<Map<String, dynamic>>('cart');
  final Map<String, dynamic> _selectedShowing =
      rawState.get<Map<String, dynamic>>('selectedShowing');

  @override
  Widget build(BuildContext context) {
    switch (widget.seat["status"]) {
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
          Text(widget.seat["seat_number"].toString()),
        ]),
      ),
      onTap: () {
        Map<String, dynamic> newCart = _cart;
        switch (widget.seat['status']) {
          case SeatStatus.reserved:
            return;
          case SeatStatus.inCart:
            newCart['seats'] = newCart['seats']
                .where((item) => item['id'] != widget.seat['id'])
                .toList();
            setState(() {
              widget.seat['status'] = SeatStatus.available;
            });
            break;
          case SeatStatus.available:
            newCart['seats'].add({
              ...widget.seat,
              "showingId": _selectedShowing['id'],
            });
            setState(() {
              widget.seat["status"] = SeatStatus.inCart;
            });
            break;
          default:
            throw Exception(
                "Bad SeatStatus in Seat widget: ${widget.seat['status']}.");
        }
        rawState.set('cart', newCart);
      },
    );
  }
}
