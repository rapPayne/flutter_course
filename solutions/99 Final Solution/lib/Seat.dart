import 'package:daam/state/seat.dart';
import 'package:flutter/material.dart';
import 'state/app_state.dart';
import 'state/superState.dart';

class Seat extends StatefulWidget {
  final Map<String, dynamic> seat;

  const Seat({super.key, required this.seat});

  @override
  State<Seat> createState() => _SeatState();
}

class _SeatState extends State<Seat> {
  late AppState _state;
  Color _seatColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    _state = SuperState.of(context).stateWrapper.state as AppState;
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
        width: 30,
        height: 30,
        child: Stack(alignment: Alignment.center, children: [
          Icon(
            Icons.weekend_rounded,
            color: _seatColor,
          ),
          Text(widget.seat["seat_number"].toString()),
        ]),
      ),
      onTap: () {
        List<Map<String, dynamic>> newCart = _state.cart;
        switch (widget.seat["status"]) {
          case SeatStatus.reserved:
            return;
          case SeatStatus.inCart:
            newCart = newCart
                .where((item) => item["id"] != widget.seat["id"])
                .toList();
            setState(() {
              widget.seat["status"] = SeatStatus.available;
            });
            break;
          case SeatStatus.available:
            newCart.add({
              ...widget.seat,
              "showingId": _state.selectedShowing!.id,
            });
            setState(() {
              widget.seat["status"] = SeatStatus.inCart;
            });
            break;
          default:
            throw Exception(
                "Bad SeatStatus in Seat widget: ${widget.seat['status']}.");
        }
        SuperState.of(context).change(_state.copyWith(cart: newCart));
      },
    );
  }
}
