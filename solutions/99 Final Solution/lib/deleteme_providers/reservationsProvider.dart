import 'package:flutter_riverpod/flutter_riverpod.dart';

class _ReservationsNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  _ReservationsNotifier() : super([]); // Passing in the initial value
  void set(List<Map<String, dynamic>> reservations) {
    state = reservations;
  }
}

final reservationsProvider =
    StateNotifierProvider<_ReservationsNotifier, List<Map<String, dynamic>>>(
        (ref) => _ReservationsNotifier());
