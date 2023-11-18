class Film {
  Film() : id = 0;
  int id;
  String? title;
  String? homepage;
  DateTime? releaseDate;
  String? overview;
  String? posterPath;
  int? runtime;
  String? tagline;
  double? popularity;
  String? imdbId;
  double? voteAverage;
  int? voteCount;

  Film.fromJson(Map<String, dynamic> json) : id = 0 {
    id = json['id'];
    title = json['title'];
    homepage = json['homepage'];
    releaseDate = DateTime.tryParse(json['release_date']);
    overview = json['overview'];
    posterPath = json['poster_path'];
    runtime = json['runtime'];
    tagline = json['tagline'];
    popularity = json['popularity'].toDouble();
    imdbId = json['imdb_id'];
    voteAverage = json['vote_average'].toDouble();
    voteCount = json['vote_count'];
  }
}
