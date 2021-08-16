import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import './Film.dart';

final titleProvider = StateProvider((_) => 'Prestige Worldwide');
final filmsProvider = StateProvider<List<Film>>((_) => <Film>[]);
final selectedDateProvider = StateProvider<DateTime?>((_) => null);
final selectedFilmProvider = StateProvider<Film?>((_) => null);
final showingsProvider = StateProvider((_) => <dynamic>[]);
final showFilmDetailsProvider = StateProvider((_) => false);

String _baseUrl = "http://localhost:3007";

// Fetch films using a strongly-typed class
Future<List<Film>> fetchFilms() {
  String url = "$_baseUrl/api/films";
  return http.get(Uri.parse(url)).then((res) {
    List<dynamic> films = jsonDecode(res.body);
    return films.map((f) => Film.fromJson(f)).toList();
  });
}

// Fetch one film by id.
Future<Film> fetchFilm({required int id}) {
  String url = "http://localhost:3007/api/films/$id";
  return http.get(Uri.parse(url)).then((res) {
    return Film.fromJson(jsonDecode(res.body));
  });
}

// Fetch showings using a dynamic Map
Future<dynamic> fetchShowings({required int film_id, required DateTime date}) {
  String url =
      "$_baseUrl/api/showings/$film_id/${DateFormat('yyyy-MM-dd').format(date)}";
  return http.get(Uri.parse(url)).then((res) => jsonDecode(res.body));
}
