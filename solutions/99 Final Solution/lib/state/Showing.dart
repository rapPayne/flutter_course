import 'Film.dart';
import '../state.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart';

class Showing {
  Showing();
  late int id;
  late int filmId;
  late int theaterId;
  late DateTime showingTime;
  Film? film;

  Showing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filmId = json['film_id'];
    theaterId = json['theater_id'];
    showingTime = DateTime.parse(json['showing_time']);
  }

  static List<Showing> showingsFromJson(List<dynamic> json) {
    return json.map((m) => Showing.fromJson(m)).toList();
  }
}

// Fetch showings using a dynamic Map
Future<List<Showing>> fetchShowings(
    {required int film_id, required DateTime date}) {
  String url =
      "${getBaseUrl()}/api/showings/$film_id/${DateFormat('yyyy-MM-dd').format(date)}";
  return get(Uri.parse(url))
      // return http
      //     .get(Uri.parse(url))
      .then((res) => jsonDecode(res.body))
      .then((res) => Showing.showingsFromJson(res));
}
