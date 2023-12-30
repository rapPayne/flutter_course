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
Future<List<dynamic>> fetchShowings(
    {required int filmId, required DateTime date}) {
  String url =
      "${getBaseUrl()}/api/showings/$filmId/${DateFormat('yyyy-MM-dd').format(date)}";
  return get(Uri.parse(url))
      // return http
      //     .get(Uri.parse(url))
      .then((res) => jsonDecode(res.body));
  //.then((res) => Showing.showingsFromJson(res));
}

// Fetch a theater
Future<Map<String, dynamic>> fetchTheater({required int theaterId}) {
  String url = "${getBaseUrl()}/api/theaters/$theaterId";
  return get(Uri.parse(url)).then((res) => jsonDecode(res.body));
}

/// Purchase film tickets
/// The purchase Map should look like this:
/// {
///   "showing_id": 100,
///   "seats": [
///     7,
///     8,
///     10,
///     22
///   ],
///   "user_id": 10,
///   "first_name": "Jo",
///   "last_name": "Smith",
///   "email": "jo.smith@gmail.com",
///   "phone": "555-555-1234",
///   "pan": "6011-0087-7345-4323",
///   "expiry_month": 1,
///   "expiry_year": 2025,
///   "cvv": 123
/// }

Future<dynamic> buyTickets({required Map<String, dynamic> purchase}) async {
  String url = "${getBaseUrl()}/api/buytickets";
  String encodedBody = jsonEncode(purchase);
  return post(Uri.parse(url), body: encodedBody);
}
