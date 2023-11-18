import 'dart:convert';
import 'package:daam/state/showing.dart';
import 'package:daam/state.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

// Fetch reservations for a showing
Future<dynamic> fetchReservationsForShowing({required int showingId}) {
  String url = "${getBaseUrl()}/api/showings/$showingId/reservations";
  Future<dynamic> res = get(Uri.parse(url)).then((res) => jsonDecode(res.body));
  return res;
}

// Fetch showings using a dynamic Map
Future<List<Showing>> fetchShowings(
    {required int filmId, required DateTime date}) {
  String url =
      "${getBaseUrl()}/api/showings/$filmId/${DateFormat('yyyy-MM-dd').format(date)}";
  return get(Uri.parse(url))
      // return http
      //     .get(Uri.parse(url))
      .then((res) => jsonDecode(res.body))
      .then((res) => Showing.showingsFromJson(res));
}
