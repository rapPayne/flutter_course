import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import './Film.dart';

final cartProvider = StateProvider<dynamic>((_) => null);
final titleProvider = StateProvider((_) => 'Prestige Worldwide');
final filmsProvider = StateProvider<List<Film>>((_) => <Film>[]);
final selectedDateProvider = StateProvider<DateTime?>((_) => null);
final selectedFilmProvider = StateProvider<Film?>((_) => null);
final selectedShowingProvider = StateProvider<dynamic>((_) => null);
final showingsProvider = StateProvider((_) => <dynamic>[]);
final showFilmDetailsProvider = StateProvider((_) => false);

String getBaseUrl({String port = "3007"}) {
  // android 10.0.2.2 via AVD
  // android 10.0.3.2 via Genymotion
  String _baseUrl = "http://127.0.0.1:$port";
  if (kIsWeb)
    return _baseUrl; // Must be first b/c Platform.operatingSystem throws on web.
  if (Platform.isAndroid)
    return "http://10.0.2.2:$port";
  else
    return _baseUrl;
}

// Fetch films using a strongly-typed class
Future<List<Film>> fetchFilms() {
  String url = "${getBaseUrl()}/api/films";
  return http.get(Uri.parse(url)).then((res) {
    List<dynamic> films = jsonDecode(res.body);
    return films.map((f) => Film.fromJson(f)).toList();
  });
}

// Fetch one film by id.
Future<Film> fetchFilm({required int id}) {
  String url = "${getBaseUrl()}/api/films/$id";
  return http.get(Uri.parse(url)).then((res) {
    return Film.fromJson(jsonDecode(res.body));
  });
}

// Fetch reservations for a showing
Future<dynamic> fetchReservationsForShowing({required int showing_id}) {
  String url = "${getBaseUrl()}/api/showings/$showing_id/reservations";
  return http.get(Uri.parse(url)).then((res) => jsonDecode(res.body));
}

// Fetch showings using a dynamic Map
Future<dynamic> fetchShowings({required int film_id, required DateTime date}) {
  String url =
      "${getBaseUrl()}/api/showings/$film_id/${DateFormat('yyyy-MM-dd').format(date)}";
  return http.get(Uri.parse(url)).then((res) => jsonDecode(res.body));
}

// Fetch a theater (which has tables and seats) using a dynamic Map
Future<dynamic> fetchTheater({required int theater_id}) {
  String url = "${getBaseUrl()}/api/theaters/$theater_id";
  return http.get(Uri.parse(url)).then((res) => jsonDecode(res.body));
}

/*
TODO: This logic should be done on the server for security reasons.
Move it there eventually. Add a firstName, lastName, etc to the 
reservation. Also, the user should be logged in at 
this point so get their int user_id also.
*/
// Make a purchase
Future<dynamic> buyTickets({required Map<String, dynamic> purchase}) async {
  // String? firstName,
  // String? lastName,
  // String? email,
  // String? phone,
  // String? creditCardNumber,
  // String? CVV,
  // String? expiryMonth,
  // String? expiryYear,
  // required int showing_id,
  // If these two don't exist, it'll throw and be caught on the outside.
  List<int> seats = purchase["seats"];
  int showing_id = purchase["showing_id"];

  String url = "${getBaseUrl()}/api/reservations";
  List<Future<dynamic>> _futures = [];
  final _payment_key = "temp_${Random().nextInt(2140000000)}";
  for (int seat_id in seats) {
    Map<String, dynamic> _body = {
      "showing_id": showing_id.toString(),
      "seat_id": seat_id.toString(),
      "user_id": 1.toString(),
      "payment_key": _payment_key,
    };
    _futures.add(http.post(Uri.parse(url), body: _body));
  }
  return Future.wait(_futures);
}
