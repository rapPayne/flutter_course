import 'package:daam/state/AppState.dart';
import 'package:daam/state/SuperState.dart';
import 'package:flutter/material.dart';
import 'state.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  late SuperState _ss;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phone;
  String? _creditCardNumber;
  String? _CVV;
  String? _expiryMonth = "01";
  String? _expiryYear;
  List<Map<String, dynamic>> _cart = [];
  GlobalKey<FormState> _key = GlobalKey();
  Map<String, dynamic> _purchase = {
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
              Text(''),
              Text('${item['price']}'),
            ]))
        .toList();
    double subtotal =
        _cart.fold<double>(0.0, (sum, item) => sum + item["price"]);
    double tax = subtotal * 0.0825;
    rows.addAll([
      TableRow(children: [
        Text(''),
        Text('Subtotal:'),
        Text(subtotal.toString()),
      ]),
      TableRow(children: [
        Text(''),
        Text('Tax:'),
        Text(tax.toString()),
      ]),
      TableRow(children: [
        Text(''),
        Text('Total:'),
        Text((subtotal + tax).toString()),
      ]),
    ]);
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    AppState state = SuperState.of(context).state;
    _email = state.customer?.email;

    void _checkout() {
      if (_key.currentState == null) return;

      if (!_key.currentState!.validate()) return;

      _key.currentState!.save();

      buyTickets(purchase: _purchase).then((res) {
        // Response will have an array of ticket numbers.
        print("success!");
        Navigator.pushNamed(context, "/ticket");
      }).catchError((err) {
        print("Error purchasing. $err");
      });
      setState(() {
        state.customer!.email = _email;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Check out"),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("Checkout"),
              const Text("Your cart"),
              Container(
                child: Table(children: _makeTableRows()),
              ),
              Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _key,
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (val) => _firstName = val,
                        validator: (val) => (val ?? "").length > 0
                            ? null
                            : "First name is required",
                        onSaved: (val) => _purchase["firstName"] = val,
                        decoration: InputDecoration(labelText: "First name"),
                      ),
                      TextFormField(
                        onChanged: (val) => _lastName = val,
                        validator: (val) => (val ?? "").length > 0
                            ? null
                            : "Last name is required",
                        onSaved: (val) => _purchase["lastName"] = val,
                        decoration: InputDecoration(labelText: "Last name"),
                      ),
                      TextFormField(
                        onChanged: (val) => _email = val,
                        initialValue: _email,
                        validator: (val) =>
                            RegExp(r"^\w+@\w+\.\w+$").hasMatch(val ?? "")
                                ? null
                                : "That isn't a valid email",
                        onSaved: (val) => _purchase["email"] = val,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: "Email", hintText: "you@yourEmail.com"),
                      ),
                      TextFormField(
                        onChanged: (val) => _phone = val,
                        onSaved: (val) => _purchase["phone"] = val,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            labelText: "Phone (optional)",
                            hintText: "xxx-xxx-xxxx"),
                      ),
                      TextFormField(
                        onChanged: (val) => _creditCardNumber = val,
                        onSaved: (val) => _purchase["creditCardNumber"] = val,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Credit card number",
                            hintText: "nnnn nnnn nnnn nnnn"),
                      ),
                      TextFormField(
                        onChanged: (val) => _CVV = val,
                        onSaved: (val) => _purchase["CVV"] = val,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: "CVV"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: DropdownButton<String>(
                                onChanged: (val) =>
                                    setState(() => _expiryMonth = val),
                                value: _expiryMonth,
                                items: <DropdownMenuItem<String>>[
                                  DropdownMenuItem<String>(
                                    child: Text("Jan"),
                                    value: "01",
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text("Feb"),
                                    value: "02",
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text("Mar"),
                                    value: "03",
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text("Apr"),
                                    value: "04",
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text("May"),
                                    value: "05",
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text("Jun"),
                                    value: "06",
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text("Jul"),
                                    value: "07",
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text("Aug"),
                                    value: "08",
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text("Sep"),
                                    value: "09",
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text("Oct"),
                                    value: "10",
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text("Nov"),
                                    value: "11",
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text("Dec"),
                                    value: "12",
                                  ),
                                ]),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: DropdownButton<String>(
                              value: _expiryYear,
                              onChanged: (val) =>
                                  setState(() => _expiryYear = val),
                              items: ["2024", "2025", "2026", "2027"]
                                  .map<DropdownMenuItem<String>>((y) =>
                                      DropdownMenuItem(
                                          child: Text(y), value: y))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.payment), onPressed: _checkout),
    );
  }
}
