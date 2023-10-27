import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'state/Film.dart';

// Cart
class _CartNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  _CartNotifier() : super([]); // Passing in the initial value
  void set(List<Map<String, dynamic>> cart) {
    state = cart;
  }
}

final cartProvider =
    StateNotifierProvider<_CartNotifier, List<Map<String, dynamic>>>(
        (ref) => _CartNotifier());

// Holds all methods to update the Films list
class _FilmsNotifier extends StateNotifier<List<Film>> {
  _FilmsNotifier() : super(<Film>[]); // Passing in the initial value
  void setAllFilms(List<Film> films) {
    state = films;
  }
}

final filmsProvider = StateNotifierProvider<_FilmsNotifier, List<Film>>(
    (ref) => _FilmsNotifier());

// Selected Date - defaults to today
class _SelectedDateProvider extends StateNotifier<DateTime> {
  _SelectedDateProvider() : super(DateTime.now());
  void set(DateTime selectedDate) {
    state = selectedDate;
  }
}

final selectedDateProvider =
    StateNotifierProvider<_SelectedDateProvider, DateTime>(
        (ref) => _SelectedDateProvider());

class _SelectedFilmProvider extends StateNotifier<Film?> {
  _SelectedFilmProvider() : super(null);
  void set(Film? film) {
    state = film;
  }
}

final selectedFilmProvider =
    StateNotifierProvider<_SelectedFilmProvider, Film?>(
        (ref) => _SelectedFilmProvider());

class _ShowFilmDetailsProvider extends StateNotifier<bool> {
  _ShowFilmDetailsProvider() : super(false);
  void set(bool showFilmDetails) {
    state = showFilmDetails;
  }
}

final showFilmDetailsProvider =
    StateNotifierProvider<_ShowFilmDetailsProvider, bool>(
        (ref) => _ShowFilmDetailsProvider());

class _TitleProvider extends StateNotifier<String> {
  _TitleProvider() : super('Prestige Worldwide');
  void set(String title) {
    state = title;
  }
}

final titleProvider =
    StateNotifierProvider<_TitleProvider, String>((ref) => _TitleProvider());

class _TheaterProvider extends StateNotifier<Map<String, dynamic>> {
  _TheaterProvider() : super({});
  void set(Map<String, dynamic> theater) {
    state = theater;
  }
}

final theaterProvider =
    StateNotifierProvider<_TheaterProvider, Map<String, dynamic>>(
        (ref) => _TheaterProvider());

String getBaseUrl({String port = "3008"}) {
  // android 10.0.2.2 via AVD
  // android 10.0.3.2 via Genymotion
  // iOS via iPhone Simulator http://localhost:$port
  // web
  //String _baseUrl = "http://127.0.0.1:$port";
  String _baseUrl = "http://localhost:$port";
  if (kIsWeb)
    return _baseUrl; // Must be first b/c Platform.operatingSystem throws on web.
  if (Platform.isMacOS) return "http://localhost:$port";
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

// Fetch a theater
Future<Map<String, dynamic>> fetchTheater({required int theater_id}) {
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
  // If these two don't exist, it'll throw and be caught on the outside.
  List<int> seats = purchase["seats"];
  int showingId = purchase["showing_id"];

  String url = "${getBaseUrl()}/api/reservations";
  List<Future<dynamic>> _futures = [];
  final _payment_key = "temp_${Random().nextInt(2140000000)}";
  for (int seat_id in seats) {
    Map<String, dynamic> _body = {
      "showing_id": showingId.toString(),
      "seat_id": seat_id.toString(),
      "user_id": 1.toString(),
      "payment_key": _payment_key,
    };
    _futures.add(http.post(Uri.parse(url), body: _body));
  }
  return Future.wait(_futures);
}
