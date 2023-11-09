import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:daam/state.dart';

// Fetch reservations for a showing
Future<dynamic> fetchReservationsForShowing({required int showing_id}) {
  String url = "${getBaseUrl()}/api/showings/$showing_id/reservations";
  Future<dynamic> res =
      http.get(Uri.parse(url)).then((res) => jsonDecode(res.body));
  return res;
}
