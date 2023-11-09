import 'package:daam/state/Seat.dart';
import 'package:flutter/material.dart';
import 'state/AppState.dart';
import 'state/SuperState.dart';

class Seat extends StatefulWidget {
  final Map<String, dynamic> seat;

  Seat({Key? key, required Map<String, dynamic> this.seat}) : super(key: key);

  @override
  State<Seat> createState() => _SeatState();
}

class _SeatState extends State<Seat> {
  late SuperState _ss;
  // SeatStatus _status = SeatStatus.available;
  Color _seatColor = Colors.blue;
  //late List<Map<String, dynamic>> _reservations;
  late List<Map<String, dynamic>> _cart;

  @override
  void didChangeDependencies() {
    _ss = SuperState.of(context);
    // assert(_ss.state.reservations != null,
    //     "Reservations should never be null here");
    _cart = _ss.state.cart;
    // setState(() {
    //   // _status = getSeatStatus(widget.seat, _ss.state.reservations!, _cart);
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
    //   print(_status);
    // });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 30,
        height: 30,
        color: _seatColor,
        child: Stack(alignment: Alignment.center, children: [
          // render seat.png
          Image.asset("assets/seat.png"),
          // LOOK HERE FOR ICONS: https://api.flutter.dev/flutter/material/Icons-class.html
          //TODO: RAP: the weekend_outlined and weekend_rounded look like chairs. Also consider "person" and "portrait"
          Text(widget.seat["seat_number"].toString()),
        ]),
      ),
      onTap: () {
        print('Adding seat ${widget.seat["id"]} to the cart.');
        AppState newState = _ss.state;
        List<Map<String, dynamic>> newCart = _cart;
        newCart.add(widget.seat);
        newState.cart = newCart;
        _ss.setState(newState);
      },
    );
  }
}
