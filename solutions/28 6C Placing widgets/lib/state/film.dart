class Film {
  int id = 0;
  String title = "";
  String? homepage;
  DateTime releaseDate = DateTime.now();
  String? overview;
  String posterPath = "";
  num runtime = 0;
  String? tagline;
  num popularity = 0.0;
  String? imdbId;
  num voteAverage = 0.0;
  num voteCount = 0;

  @override
  String toString() {
    return 'Film: $title - $tagline ($overview)';
  }
}
