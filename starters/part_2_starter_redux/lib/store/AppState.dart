import '../Film.dart';

class AppState {
  dynamic cart;
  List<Film> films;
  DateTime? selectedDate;
  Film? selectedFilm;
  dynamic selectedShowing;
  List<dynamic> showings = [];
  dynamic theater;

  AppState(
      {this.cart,
      this.films = const [],
      this.showings = const [],
      this.selectedDate,
      this.selectedFilm,
      this.selectedShowing,
      this.theater});

  copyWith({
    dynamic newCart,
    dynamic newFilms,
    DateTime? newSelectedDate,
    Film? newSelectedFilm,
    dynamic newSelectedShowing,
    List<dynamic>? newShowings,
    dynamic newTheater,
  }) {
    AppState newAppState = AppState(
      cart: newCart ?? this.cart,
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
