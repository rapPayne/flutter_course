import 'package:daam/state.dart';
import 'package:flutter/material.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phone;
  String? _creditCardNumber;
  String? _CVV;
  String? _expiryMonth = "01";
  String? _expiryYear;
  GlobalKey<FormState> _key = GlobalKey();
  Map<String, dynamic> _purchase = {
    "seats": [1, 2, 3],
    "showing_id": 1,
  };

  void _checkout() {
    if (_key.currentState == null) return;

    if (!_key.currentState!.validate()) return;

    _key.currentState!.save();

    buyTickets(purchase: _purchase).then((res) {
      // Response will have an array of ticket numbers.
      print("success!");
    }).catchError((err) {
      print("Error purchasing. ${err}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text("Checkout"),
          const Text("Your cart"),
          Container(
            child: Text(""),
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
                    validator: (val) =>
                        (val ?? "").length > 0 ? null : "Last name is required",
                    onSaved: (val) => _purchase["lastName"] = val,
                    decoration: InputDecoration(labelText: "Last name"),
                  ),
                  TextFormField(
                    onChanged: (val) => _email = val,
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
                        labelText: "Phone (option)", hintText: "xxx-xxx-xxxx"),
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
                  DropdownButton<String>(
                      onChanged: (val) => setState(() => _expiryMonth = val),
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
                  DropdownButton<String>(
                    value: _expiryYear,
                    onChanged: (val) => setState(() => _expiryYear = val),
                    items: ["2021", "2022", "2023", "2024"]
                        .map<DropdownMenuItem<String>>(
                            (y) => DropdownMenuItem(child: Text(y), value: y))
                        .toList(),
                  ),
                ],
              )),
          FloatingActionButton(child: Icon(Icons.payment), onPressed: _checkout)
        ],
      ),
    );
  }
}
