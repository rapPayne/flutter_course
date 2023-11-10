import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';

import 'film.dart';

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
  if (Platform.isMacOS) return "http://localhost:$port";
  if (Platform.isAndroid) {
    return "http://10.0.2.2:$port";
  } else {
    return baseUrl;
  }
}

// Fetch films using a strongly-typed class
Future<List<Film>> fetchFilms() {
  String url = "${getBaseUrl()}/api/films";
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
  });
}

// Fetch showings using a dynamic List
Future<List<dynamic>> fetchShowings(
    {required int filmId, required DateTime date}) {
  String url =
      "${getBaseUrl()}/api/showings/$filmId/${DateFormat('yyyy-MM-dd').format(date)}";
  return get(Uri.parse(url)).then((res) => jsonDecode(res.body));
}

// Make a list of five days
List<DateTime> makeConsecutiveDates(int howMany, DateTime startDate) {
  List<DateTime> dates = <DateTime>[];
  for (int i = 0; i < 5; i++) {
    DateTime day = startDate.add(Duration(days: i));
    dates.add(day);
  }
  return dates;
}
