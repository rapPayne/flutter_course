class Film {
  int id = 0;
  String title = "";
  String homepage = "";
  DateTime releaseDate = DateTime.now();
  String overview = "";
  String posterPath = "";
  int runtime = 0;
  String tagline = "";
  double popularity = 0.0;
  String imdbId = "";
  double voteAverage = 0.0;
  int voteCount = 0;

  @override
  String toString() {
    return 'Film: ' +
        this.title +
        ' - ' +
        this.tagline +
        ' (' +
        this.overview +
        ')';
  }
}
