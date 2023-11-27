import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'state/movie.dart';

String getBaseUrl({String port = "3008"}) {
  // android 10.0.2.2 via AVD
  // android 10.0.3.2 via Genymotion
  // iOS via iPhone Simulator http://localhost:$port
  // web
  //String baseUrl = "http://127.0.0.1:$port";
  String baseUrl = "http://localhost:$port";
  if (kIsWeb) {
    return baseUrl; // Must be first b/c Platform.operatingSystem throws on web.
  }
  if (Platform.isMacOS) return "http://localhost:$port";
  if (Platform.isAndroid) {
    return "http://10.0.2.2:$port";
  } else {
    return baseUrl;
  }
}

// Fetch films using a strongly-typed class
Future<List<Movie>> fetchFilms() {
  String url = "${getBaseUrl()}/api/films";
  return http.get(Uri.parse(url)).then((res) {
    List<dynamic> films = jsonDecode(res.body);
    return films.map((f) => Movie.fromJson(f)).toList();
  });
}

// Fetch one film by id.
Future<Movie> fetchFilm({required int id}) {
  String url = "${getBaseUrl()}/api/films/$id";
  return http.get(Uri.parse(url)).then((res) {
    return Movie.fromJson(jsonDecode(res.body));
  });
}

// Fetch a theater
Future<Map<String, dynamic>> fetchTheater({required int theaterId}) {
  String url = "${getBaseUrl()}/api/theaters/$theaterId";
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
  List<Future<dynamic>> futures = [];
  final paymentKey = "temp_${Random().nextInt(2140000000)}";
  for (int seatId in seats) {
    Map<String, dynamic> body = {
      "showing_id": showingId.toString(),
      "seat_id": seatId.toString(),
      "user_id": 1.toString(),
      "payment_key": paymentKey,
    };
    futures.add(http.post(Uri.parse(url), body: body));
  }
  return Future.wait(futures);
}
