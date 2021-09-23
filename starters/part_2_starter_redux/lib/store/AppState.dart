import '../Film.dart';

class AppState {
  DateTime? selectedDate;
  List<Film> films;
  Film? selectedFilm;
  dynamic selectedShowing;
  List<dynamic> showings = [];
  dynamic theater;

  AppState(
      {this.selectedDate,
      this.films = const [],
      this.showings = const [],
      this.selectedFilm,
      this.selectedShowing,
      this.theater});

  copyWith({
    dynamic newFilms,
    DateTime? newSelectedDate,
    Film? newSelectedFilm,
    dynamic newSelectedShowing,
    List<dynamic>? newShowings,
    dynamic newTheater,
  }) {
    AppState newAppState = AppState(
      films: newFilms ?? this.films,
      selectedDate: newSelectedDate ?? this.selectedDate,
      selectedFilm: newSelectedFilm ?? this.selectedFilm,
      selectedShowing: newSelectedShowing ?? this.selectedShowing,
      showings: newShowings ?? this.showings,
      theater: newTheater ?? this.theater,
    );
    return newAppState;
  }

  String toString() {
    return "{selectedDate:" + this.selectedDate.toString() + "}";
  }
}
