import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:daam/state.dart';

class _ReservationsNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  _ReservationsNotifier() : super([]); // Passing in the initial value
  void set(List<Map<String, dynamic>> reservations) {
    state = reservations;
  }
}

final reservationsProvider =
    StateNotifierProvider<_ReservationsNotifier, List<Map<String, dynamic>>>(
        (ref) => _ReservationsNotifier());

// Fetch reservations for a showing
Future<dynamic> fetchReservationsForShowing({required int showing_id}) {
  String url = "${getBaseUrl()}/api/showings/$showing_id/reservations";
  Future<dynamic> res =
      http.get(Uri.parse(url)).then((res) => jsonDecode(res.body));
  return res;
}
