import 'package:daam/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:daam/state/Seat.dart';
import 'package:flutter/material.dart';
import 'providers/reservationsProvider.dart';

class Seat extends ConsumerStatefulWidget {
  final Map<String, dynamic> seat;

  Seat({Key? key, required Map<String, dynamic> this.seat}) : super(key: key);

  @override
  ConsumerState<Seat> createState() => _SeatState();
}

class _SeatState extends ConsumerState<Seat> {
  SeatStatus _status = SeatStatus.available;
  Color _seatColor = Colors.blue;
  late List<Map<String, dynamic>> _reservations;
  late List<Map<String, dynamic>> _cart;
  @override
  void initState() {
    _reservations = ref.read(reservationsProvider);
    _cart = ref.read(
        cartProvider); // watch because we're changing the cart by adding to it and removing from it.
    setState(() {
      _status = getSeatStatus(widget.seat, _reservations, _cart);
      switch (_status) {
        case SeatStatus.reserved:
          _seatColor = Colors.grey;
          break;
        case SeatStatus.inCart:
          _seatColor = Colors.red;
          break;
        default:
          _seatColor = Colors.blue;
      }
      print(_status);
    });
    super.initState();
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
        ref.read(cartProvider.notifier).set([..._cart, widget.seat]);
      },
    );
  }

  SeatStatus getSeatStatus(Map seat, List<Map<String, dynamic>> reservations,
      List<Map<String, dynamic>> cart) {
    bool seatIsReserved = _reservations
        .any((reservation) => reservation['seat_id'] == seat['id']);
    if (seatIsReserved) return SeatStatus.reserved;
    bool seatIsInCart =
        cart.any((heldSeat) => heldSeat['seat_id'] == seat['id']);
    if (seatIsInCart) return SeatStatus.inCart;
    return SeatStatus.available;
  }
}
