class AppState {
  AppState({this.person, this.creditCard, this.cart});
  final Person? person;
  final CreditCard? creditCard;
  final Cart? cart;

  AppState copyWith({Person? person, CreditCard? creditCard, Cart? cart}) {
    return AppState(
        cart: cart ?? this.cart,
        creditCard: creditCard ?? this.creditCard,
        person: person ?? this.person);
  }
}

class Person {
  String first = '';
  String last = '';
  String email = '';
  String phone = '';
}

class CreditCard {
  String pan = '';
  int cvv = 0;
  DateTime expiry = DateTime.now();
}

class Cart {
  List<CartLine> lines = [];
}

class CartLine {
  CartLine({required this.product, required this.quantity});
  final Product product;
  final int quantity;
}

class Product {
  Product({required this.name, required this.price});
  final String name;
  final double price;
}
