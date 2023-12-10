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
  int? cvv;
}
