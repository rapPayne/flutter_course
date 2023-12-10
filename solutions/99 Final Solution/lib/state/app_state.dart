import 'showing.dart';
import 'movie.dart';
import 'customer.dart';

class AppState {
  List<Map<String, dynamic>> cart = [];
  Customer? customer;
  List<Map<String, dynamic>>? reservations;
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  Movie? selectedFilm;
  Showing? selectedShowing;
  Map<String, dynamic>? theater;

  AppState copyWith(
      {List<Map<String, dynamic>>? cart,
      Customer? customer,
      List<Map<String, dynamic>>? reservations,
      DateTime? selectedDate,
      Movie? selectedFilm,
      Showing? selectedShowing,
      Map<String, dynamic>? theater}) {
    return AppState()
      ..cart = cart ?? this.cart
      ..customer = customer ?? this.customer
      ..reservations = reservations ?? this.reservations
      ..selectedDate = selectedDate ?? this.selectedDate
      ..selectedFilm = selectedFilm ?? this.selectedFilm
      ..selectedShowing = selectedShowing ?? this.selectedShowing
      ..theater = theater ?? this.theater;
  }
}

DateTime now = DateTime.now();
DateTime today = DateTime.utc(now.year, now.month, now.day);
