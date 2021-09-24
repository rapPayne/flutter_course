import 'package:redux/redux.dart';
import 'Actions.dart';
import 'AppState.dart';
import 'middleware.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../Film.dart';

// These hardcoded values should really be read from an Ajax
// service. We're only providing them here to mock up screens
// so that the code will be simpler to follow.
AppState initialState = new AppState(
  selectedDate: DateTime.now(),
  films: <Film>[],
  showings: [],
);

AppState reducer(AppState oldState, dynamic action) {
  switch (action['type']) {
    case Actions.ADD_FILM:
      List<Film> newFilms = oldState.films;
      newFilms.add(action['film']);
      return oldState.copyWith(newFilms: newFilms);
    case Actions.SET_CART:
      return oldState.copyWith(newCart: action['cart']);
    case Actions.SET_SELECTED_DATE:
      return oldState.copyWith(newSelectedDate: action['date']);
    case Actions.SET_SELECTED_FILM:
      return oldState.copyWith(newSelectedFilm: action['film']);
    case Actions.SET_SELECTED_SHOWING:
      return oldState.copyWith(newSelectedShowing: action['showing']);
    case Actions.SET_SHOWINGS:
      return oldState.copyWith(newShowings: action['showings']);
    case Actions.SET_THEATER:
      return oldState.copyWith(newTheater: action['theater']);
    default:
      return oldState;
  }
}

final store =
    new Store<AppState>(reducer, initialState: initialState, middleware: [
  BuyTicketsMiddleware(),
  FetchFilmsMiddleware(),
  FetchShowingsMiddleware(),
  FetchTheaterMiddleware()
]);

// Actions below?
class AddFilmAction {
  final Film film;
  AddFilmAction(this.film);
}

class FetchFilmsAction {}

class SetSelectedDateAction {
  final DateTime date;
  SetSelectedDateAction(this.date);
}

String getBaseUrl({String port = "3007"}) {
  // android 10.0.2.2 via AVD
  // android 10.0.3.2 via Genymotion
  String _baseUrl = "http://127.0.0.1:$port";
  if (kIsWeb)
    return _baseUrl; // Must be first b/c Platform.operatingSystem throws on web.
  if (Platform.isAndroid)
    return "http://10.0.2.2:$port";
  else
    return _baseUrl;
}
