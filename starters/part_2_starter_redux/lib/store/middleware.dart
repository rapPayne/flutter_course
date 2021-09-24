import 'package:redux/redux.dart';
import 'AppState.dart';
import 'Actions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'store.dart' show getBaseUrl;
import '../Film.dart';
import 'dart:math';

// void fetchFilmsMiddleware = ({ dispatch, getState }) => next => action => {
//   if (action.type === "FETCH_FILMS") {
//     fetch("http://localhost:5000/api/films")
//       .then(res => res.json())
//       .then(films => films.forEach(film => dispatch({ type: "ADD_FILM", film })))
//       .catch(err => console.error("Couldn't fetch films", err))
//   }
//   next(action);
// }

class BuyTicketsMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action['type'] == Actions.BUY_TICKETS) {
      dynamic purchase = action["purchase"];
      List<int> seats = purchase["seats"];
      int showing_id = purchase["showing_id"];

      String url = "${getBaseUrl()}/api/reservations";
      final _payment_key = "temp_${Random().nextInt(2140000000)}";
      List<Future<dynamic>> _futures = [];

      for (int seat_id in seats) {
        Map<String, dynamic> _body = {
          "showing_id": showing_id.toString(),
          "seat_id": seat_id.toString(),
          "user_id": 1.toString(),
          "payment_key": _payment_key,
        };
        _futures.add(http.post(Uri.parse(url), body: _body));
      }
      Future.wait(_futures).then((res) {
        // List<dynamic> tickets = jsonDecode(res.body);
        store.dispatch({'type': "ALL_PURCHASE_DONE" /* All purchases done */});
      });
    }
    next(action);
  }
}

Future<dynamic> buyTickets({required Map<String, dynamic> purchase}) async {
  // If these two don't exist, it'll throw and be caught on the outside.
  List<int> seats = purchase["seats"];
  int showing_id = purchase["showing_id"];

  String url = "${getBaseUrl()}/api/reservations";
  List<Future<dynamic>> _futures = [];
  final _payment_key = "temp_${Random().nextInt(2140000000)}";
  for (int seat_id in seats) {
    Map<String, dynamic> _body = {
      "showing_id": showing_id.toString(),
      "seat_id": seat_id.toString(),
      "user_id": 1.toString(),
      "payment_key": _payment_key,
    };
    _futures.add(http.post(Uri.parse(url), body: _body));
  }
  return Future.wait(_futures);
}

class FetchFilmsMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action['type'] == Actions.FETCH_FILMS) {
      String url = "${getBaseUrl()}/api/films";

      http.get(Uri.parse(url)).then((res) {
        List<dynamic> filmsMap = jsonDecode(res.body);
        List<Film> films = filmsMap.map((f) => Film.fromJson(f)).toList();
        for (var i = 0; i < films.length; i++) {
          store.dispatch({"type": Actions.ADD_FILM, "film": films[i]});
        }
        print("objects ${films[0].title}");
      });
    }
    next(action);
  }
}

class FetchShowingsMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action['type'] == Actions.FETCH_SHOWINGS) {
      String url =
          "${getBaseUrl()}/api/showings/${action['film_id']}/${DateFormat('yyyy-MM-dd').format(action['date'])}";
      http.get(Uri.parse(url)).then((res) {
        List<dynamic> showings = jsonDecode(res.body);
        store.dispatch({'type': Actions.SET_SHOWINGS, 'showings': showings});
      });
    }
    next(action);
  }
}

class FetchTheaterMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action['type'] == Actions.FETCH_THEATER) {
      String url = "${getBaseUrl()}/api/theaters/${action['theater_id']}";
      http.get(Uri.parse(url)).then((res) {
        dynamic theater = jsonDecode(res.body);
        store.dispatch({'type': Actions.SET_THEATER, 'theater': theater});
      });
    }
    next(action);
  }
}

//var middlewares = [_FetchFilmsMiddleware(), _FetchShowingsMiddleware()];
