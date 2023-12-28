// ignore_for_file: file_names
import 'package:daam/state/global.dart';
import 'package:daam/state/showing.dart';
import 'package:flutter/material.dart';
import 'state.dart';
import './state/customer.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String? _first;
  String? _last;
  String? _email;
  String? _phone;
  String? _pan;
  String? _cvv;
  String? _expiryMonth;
  String? _expiryYear;
  final Map<String, dynamic> _purchase = {};
  final List<Map<String, dynamic>> _cart =
      global.get<List<Map<String, dynamic>>>('cart');
  Showing selectedShowing = global.get<Showing>("selectedShowing");
  final Customer? _customer = global.maybeGet<Customer>('customer');

  final GlobalKey<FormState> _key = GlobalKey();

  List<TableRow> _makeTableRows() {
    List<TableRow> rows = _cart
        .map((item) => TableRow(children: [
              Text('Table ${item['table_number']} Seat ${item['seat_number']}'),
              const Text(''),
              Text('${item['price']}'),
            ]))
        .toList();
    double subtotal =
        _cart.fold<double>(0.0, (sum, item) => sum + item["price"]);
    double tax = subtotal * 0.0825;
    rows.addAll([
      TableRow(children: [
        const Text(''),
        const Text('Subtotal:'),
        Text(subtotal.toString()),
      ]),
      TableRow(children: [
        const Text(''),
        const Text('Tax:'),
        Text(tax.toString()),
      ]),
      TableRow(children: [
        const Text(''),
        const Text('Total:'),
        Text((subtotal + tax).toString()),
      ]),
    ]);
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    _purchase["showing_id"] = selectedShowing.id;
    _purchase["seats"] = _cart.map((seat) => seat["id"]).toList();
    _first = _customer?.first;
    _last = _customer?.last;
    _email = _customer?.email;
    _phone = _customer?.phone;
    _pan = _customer?.creditCard?.pan;
    _expiryMonth = _customer?.creditCard?.expiryMonth.toString();
    _expiryYear = _customer?.creditCard?.expiryYear.toString();
    _cvv = _customer?.creditCard?.cvv.toString();

    void checkout() {
      if (_key.currentState == null) return;
      if (!_key.currentState!.validate()) return;
      _key.currentState!.save();

      buyTickets(purchase: _purchase).then((res) {
        // TODO: Send POST request to buyTickets(). Response will have an array of ticket numbers.
        // Empty out the cart
        global.set("cart", []);
        Navigator.pushNamed(context, "/ticket");
      }).catchError((err) {
        // ignore: avoid_print
        print("Error purchasing. $err");
      });

      var creditCard = CreditCard()
        ..cvv = int.tryParse(_cvv ?? "")
        ..expiryMonth = int.tryParse(_expiryMonth ?? "")
        ..expiryYear = int.tryParse(_expiryYear ?? "")
        ..pan = _pan;
      var customer = Customer()
        ..creditCard = creditCard
        ..email = _email
        ..first = _first
        ..last = _last
        ..phone = _phone;
      global.set("customer", customer);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Check out"),
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("Checkout"),
              const Text("Your cart"),
              Table(children: _makeTableRows()),
              _makeCheckoutForm(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => checkout(), child: const Icon(Icons.payment)),
    );
  }

  Widget _makeCheckoutForm() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _key,
      child: Column(
        children: [
          TextFormField(
            onChanged: (val) => _first = val,
            validator: (val) =>
                (val ?? "").isNotEmpty ? null : "First name is required",
            onSaved: (val) => _purchase["first_name"] = val,
            decoration: const InputDecoration(labelText: "First name"),
          ),
          TextFormField(
            onChanged: (val) => _last = val,
            validator: (val) =>
                (val ?? "").isNotEmpty ? null : "Last name is required",
            onSaved: (val) => _purchase["last_name"] = val,
            decoration: const InputDecoration(labelText: "Last name"),
          ),
          TextFormField(
            onChanged: (val) => _email = val,
            initialValue: _email,
            validator: (val) => RegExp(r"^\w+@\w+\.\w+$").hasMatch(val ?? "")
                ? null
                : "That isn't a valid email",
            onSaved: (val) => _purchase["email"] = val,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                labelText: "Email", hintText: "you@yourEmail.com"),
          ),
          TextFormField(
            onChanged: (val) => _phone = val,
            onSaved: (val) => _purchase["phone"] = val,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
                labelText: "Phone (optional)", hintText: "xxx-xxx-xxxx"),
          ),
          TextFormField(
            onChanged: (val) => _pan = val,
            onSaved: (val) => _purchase["pan"] = val,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                labelText: "Credit card number",
                hintText: "nnnn nnnn nnnn nnnn"),
          ),
          TextFormField(
            onChanged: (val) => _cvv = val,
            onSaved: (val) => _purchase["cvv"] = val,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "CVV"),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: DropdownButtonFormField<String>(
                  onChanged: (val) => setState(() => _expiryMonth = val),
                  onSaved: (val) => _purchase["expiry_month"] = val,
                  value: _expiryMonth,
                  items: _expiryMonths,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: DropdownButtonFormField<String>(
                  value: _expiryYear,
                  onChanged: (val) => setState(() => _expiryYear = val),
                  onSaved: (val) => _purchase["expiry_month"] = val,
                  items: _makeExpiryYears(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final List<DropdownMenuItem<String>> _expiryMonths = [
    const DropdownMenuItem(
      value: "01",
      child: Text("Jan"),
    ),
    const DropdownMenuItem(
      value: "02",
      child: Text("Feb"),
    ),
    const DropdownMenuItem(
      value: "03",
      child: Text("Mar"),
    ),
    const DropdownMenuItem(
      value: "04",
      child: Text("Apr"),
    ),
    const DropdownMenuItem(
      value: "05",
      child: Text("May"),
    ),
    const DropdownMenuItem(
      value: "06",
      child: Text("Jun"),
    ),
    const DropdownMenuItem(
      value: "07",
      child: Text("Jul"),
    ),
    const DropdownMenuItem(
      value: "08",
      child: Text("Aug"),
    ),
    const DropdownMenuItem(
      value: "09",
      child: Text("Sep"),
    ),
    const DropdownMenuItem(
      value: "10",
      child: Text("Oct"),
    ),
    const DropdownMenuItem(
      value: "11",
      child: Text("Nov"),
    ),
    const DropdownMenuItem(
      value: "12",
      child: Text("Dec"),
    ),
  ];

  List<DropdownMenuItem<String>> _makeExpiryYears() {
    int currentYear = DateTime.now().year;
    return [
      for (int year = currentYear; year <= currentYear + 4; year++)
        DropdownMenuItem<String>(
          value: year.toString(),
          child: Text(year.toString()),
        ),
    ];
  }
}
