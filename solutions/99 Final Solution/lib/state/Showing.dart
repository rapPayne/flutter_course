import 'Film.dart';

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
