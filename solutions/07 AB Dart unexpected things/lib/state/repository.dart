import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';
import 'film.dart';

/// Returns the best URL string based on the running platform.
/// The different platforms block different URLs. This function
/// allows us to request API data regardless of where we're
/// debugging.
String getBaseUrl({String port = "3008"}) {
  // android 10.0.2.2 via AVD
  // android 10.0.3.2 via Genymotion
  // iOS via iPhone Simulator http://localhost:$port
  // web
  //String _baseUrl = "http://127.0.0.1:$port";
  String baseUrl = "http://localhost:$port";
  if (kIsWeb) {
    return baseUrl; // Must be first b/c Platform.operatingSystem throws on web.
  }
  print("Platform.environment is ${Platform.operatingSystem}");
  if (Platform.isMacOS) return "http://localhost:$port";
  if (Platform.isAndroid) {
    return "http://10.0.2.2:$port";
  } else {
    return baseUrl;
  }
}

// Fetch films using a strongly-typed class
Future<List<Film>> fetchFilms() {
  String url = '${getBaseUrl()}/api/films';
  return get(Uri.parse(url)).then((res) {
    List<dynamic> films = jsonDecode(res.body);
    return films
        .map((f) => Film()
          ..id = f['id']
          ..homepage = f['homepage']
          ..imdbId = f['imdb_id']
          ..overview = f['overview']
          ..popularity = f['popularity']
          ..posterPath = f['poster_path']
          ..releaseDate = DateTime.parse(f['release_date'])
          ..runtime = f['runtime']
          ..tagline = f['tagline']
          ..title = f['title']
          ..voteAverage = f['vote_average']
          ..voteCount = f['vote_count'])
        .toList();
  }).catchError((err) {
    print("Problem fetching films!");
    print(err);
    return <Film>[];
  });
}

// Fetch reservations for a showing
Future<dynamic> fetchReservationsForShowing({required int showingId}) {
  String url = "${getBaseUrl()}/api/showings/$showingId/reservations";
  return get(Uri.parse(url)).then((res) => jsonDecode(res.body));
}

// Fetch showings using a dynamic List
Future<List<dynamic>> fetchShowings(
    {required int filmId, required DateTime date}) {
  String url =
      "${getBaseUrl()}/api/showings/$filmId/${DateFormat('yyyy-MM-dd').format(date)}";
  return get(Uri.parse(url)).then((res) => jsonDecode(res.body));
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

// Make a list of five days
List<DateTime> makeConsecutiveDates(
    {int howMany = 5, required DateTime startDate}) {
  List<DateTime> dates = <DateTime>[];
  for (int i = 0; i < 5; i++) {
    DateTime day = startDate.add(Duration(days: i));
    dates.add(day);
  }
  return dates;
}
