class Film {
  Film() : id = 0;
  int id;
  String? title;
  String? homepage;
  DateTime? release_date;
  String? overview;
  String? poster_path;
  int? runtime;
  String? tagline;
  double? popularity;
  String? imdb_id;
  double? vote_average;
  int? vote_count;

  Film.fromJson(Map<String, dynamic> json) : id = 0 {
    id = json['id'];
    title = json['title'];
    homepage = json['homepage'];
    release_date = DateTime.tryParse(json['release_date']);
    overview = json['overview'];
    poster_path = json['poster_path'];
    runtime = json['runtime'];
    tagline = json['tagline'];
    popularity = json['popularity'].toDouble();
    imdb_id = json['imdb_id'];
    vote_average = json['vote_average'].toDouble();
    vote_count = json['vote_count'];
  }
}
