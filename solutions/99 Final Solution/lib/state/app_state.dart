import 'showing.dart';
import 'Film.dart';

class AppState {
  List<Map<String, dynamic>> cart = [];
  Customer? customer;
  List<Map<String, dynamic>>? reservations;
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  Film? selectedFilm;
  Showing? selectedShowing;
  Map<String, dynamic>? theater;
}

DateTime now = DateTime.now();
DateTime today = DateTime.utc(now.year, now.month, now.day);

class Customer {
  int? id;
  String? username;
  String? password;
  String? first;
  String? last;
  String? phone;
  String? email;
  CreditCard? creditCard;
}

class CreditCard {
  String? pan;
  int? expiryMonth;
  int? expiryYear;
}
