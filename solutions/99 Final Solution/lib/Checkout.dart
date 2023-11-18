import 'package:daam/state/app_state.dart';
import 'package:daam/state/superState.dart';
import 'package:flutter/material.dart';
import 'state.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  late SuperState _ss;
  // ignore: unused_field
  String? _firstName;
  // ignore: unused_field
  String? _lastName;
  String? _email;
  // ignore: unused_field
  String? _phone;
  // ignore: unused_field
  String? _creditCardNumber;
  // ignore: unused_field
  String? _cvv;
  String? _expiryMonth;
  String? _expiryYear;
  List<Map<String, dynamic>> _cart = [];
  final GlobalKey<FormState> _key = GlobalKey();
  final Map<String, dynamic> _purchase = {
    "seats": [1, 2, 3],
    "showing_id": 1,
  };

  @override
  void didChangeDependencies() {
    _ss = SuperState.of(context);
    _cart = _ss.state.cart;
    super.didChangeDependencies();
  }

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
    AppState state = SuperState.of(context).state;
    _email = state.customer?.email;

    void checkout() {
      if (_key.currentState == null) return;

      if (!_key.currentState!.validate()) return;

      _key.currentState!.save();

      buyTickets(purchase: _purchase).then((res) {
        // Response will have an array of ticket numbers.
        Navigator.pushNamed(context, "/ticket");
      }).catchError((err) {
        // ignore: avoid_print
        print("Error purchasing. $err");
      });
      setState(() {
        state.customer!.email = _email;
      });
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
          onPressed: checkout, child: const Icon(Icons.payment)),
    );
  }

  Widget _makeCheckoutForm() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _key,
      child: Column(
        children: [
          TextFormField(
            onChanged: (val) => _firstName = val,
            validator: (val) =>
                (val ?? "").isNotEmpty ? null : "First name is required",
            onSaved: (val) => _purchase["firstName"] = val,
            decoration: const InputDecoration(labelText: "First name"),
          ),
          TextFormField(
            onChanged: (val) => _lastName = val,
            validator: (val) =>
                (val ?? "").isNotEmpty ? null : "Last name is required",
            onSaved: (val) => _purchase["lastName"] = val,
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
            onChanged: (val) => _creditCardNumber = val,
            onSaved: (val) => _purchase["creditCardNumber"] = val,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                labelText: "Credit card number",
                hintText: "nnnn nnnn nnnn nnnn"),
          ),
          TextFormField(
            onChanged: (val) => _cvv = val,
            onSaved: (val) => _purchase["CVV"] = val,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "CVV"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: DropdownButton<String>(
                    onChanged: (val) => setState(() => _expiryMonth = val),
                    value: _expiryMonth,
                    items: const <DropdownMenuItem<String>>[
                      DropdownMenuItem<String>(
                        value: "01",
                        child: Text("Jan"),
                      ),
                      DropdownMenuItem<String>(
                        value: "02",
                        child: Text("Feb"),
                      ),
                      DropdownMenuItem<String>(
                        value: "03",
                        child: Text("Mar"),
                      ),
                      DropdownMenuItem<String>(
                        value: "04",
                        child: Text("Apr"),
                      ),
                      DropdownMenuItem<String>(
                        value: "05",
                        child: Text("May"),
                      ),
                      DropdownMenuItem<String>(
                        value: "06",
                        child: Text("Jun"),
                      ),
                      DropdownMenuItem<String>(
                        value: "07",
                        child: Text("Jul"),
                      ),
                      DropdownMenuItem<String>(
                        value: "08",
                        child: Text("Aug"),
                      ),
                      DropdownMenuItem<String>(
                        value: "09",
                        child: Text("Sep"),
                      ),
                      DropdownMenuItem<String>(
                        value: "10",
                        child: Text("Oct"),
                      ),
                      DropdownMenuItem<String>(
                        value: "11",
                        child: Text("Nov"),
                      ),
                      DropdownMenuItem<String>(
                        value: "12",
                        child: Text("Dec"),
                      ),
                    ]),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: DropdownButton<String>(
                  value: _expiryYear,
                  onChanged: (val) => setState(() => _expiryYear = val),
                  items: ["2024", "2025", "2026", "2027"]
                      .map<DropdownMenuItem<String>>(
                          (y) => DropdownMenuItem(value: y, child: Text(y)))
                      .toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
