import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'state/movie.dart';

/// Returns the proper root URL for the OS
///
/// For MacOS, you should also edit MacOS entitlements and add this to
/// macos/Runner/DebugProfile.entitlements
/// <key>com.apple.security.network.client</key>
/// <true/>
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
  if (Platform.isMacOS) return baseUrl;
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
  return http.post(Uri.parse(url), body: encodedBody);
}
