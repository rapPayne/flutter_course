import 'package:daam/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'state.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _cell;
  String? _phone;
  String? _creditCardNumber;
  String? _CVV;
  String? _expiryMonth;
  String? _expiryYear;
  Map<String, dynamic> _purchase = {
    "seats": [1, 2, 3],
    "showing_id": 1,
  };
  List<Map<String, dynamic>> _cart = [];
  var _key = GlobalKey<FormState>();

  void _checkout() {
    print("checking out");
    // If currentState is null, fail validation and return. If validate() fails, return.
    if (!(_key.currentState?.validate() ?? false)) return;
    _key.currentState?.save();

    buyTickets(purchase: _purchase).then((res) {
      // Response will have an array of ticket numbers.
      print("success!");
      Navigator.pushNamed(context, '/tickets');
    }).catchError((err) {
      print("Error purchasing. ${err}");
    });
  }

  @override
  Widget build(BuildContext context) {
    _cart = context.read(cartProvider).state;
    return Scaffold(
      appBar: AppBar(title: Text("Check out and pay")),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("Your cart"),
              Container(
                child: Text(""),
              ),
              TextFormField(
                onChanged: (String val) => setState(() => _firstName = val),
                onSaved: (val) => _purchase["firstName"] = val,
                decoration: InputDecoration(
                  label: Text("First name"),
                ),
              ),
              TextFormField(
                onChanged: (String val) => setState(() => _lastName = val),
                onSaved: (val) => _purchase["lastName"] = val,
                decoration: InputDecoration(
                  label: Text("Last name"),
                ),
              ),
              TextFormField(
                onChanged: (String val) => setState(() => _email = val),
                onSaved: (val) => _purchase["email"] = val,
                decoration: InputDecoration(
                  label: Text("Email"),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                onChanged: (String val) => setState(() => _phone = val),
                onSaved: (val) => _purchase["phone"] = val,
                decoration: InputDecoration(
                  label: Text("Phone"),
                ),
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                onChanged: (String val) =>
                    setState(() => _creditCardNumber = val),
                onSaved: (val) => _purchase["creditCardNumber"] = val,
                validator: (val) {
                  var re = RegExp(r"^((\d{4})[ -]?){4}$");
                  if (!re.hasMatch(val ?? ""))
                    return 'That is not a credit card. Give me a real card.';
                },
                decoration: InputDecoration(
                  label: Text("Credit Card"),
                ),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                onChanged: (String val) => setState(() => _CVV = val),
                onSaved: (val) => _purchase["CVV"] = val,
                decoration: InputDecoration(
                  label: Text("CVV"),
                ),
                keyboardType: TextInputType.number,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FormField(
                    onSaved: (val) => _purchase["expiryMonth"] = val,
                    builder: (state) => DropdownButton(
                      value: _expiryMonth,
                      onChanged: (String? val) =>
                          setState(() => _expiryMonth = val),
                      items: [
                        DropdownMenuItem(
                          child: Text("Jan"),
                          value: "01",
                        ),
                        DropdownMenuItem(
                          child: Text("Feb"),
                          value: "02",
                        ),
                        DropdownMenuItem(
                          child: Text("Mar"),
                          value: "03",
                        ),
                        DropdownMenuItem(
                          child: Text("Apr"),
                          value: "04",
                        ),
                        DropdownMenuItem(
                          child: Text("May"),
                          value: "05",
                        ),
                        DropdownMenuItem(
                          child: Text("Jun"),
                          value: "06",
                        ),
                        DropdownMenuItem(
                          child: Text("Jul"),
                          value: "07",
                        ),
                        DropdownMenuItem(
                          child: Text("Jan"),
                          value: "08",
                        ),
                        DropdownMenuItem(
                          child: Text("Sep"),
                          value: "09",
                        ),
                        DropdownMenuItem(
                          child: Text("Oct"),
                          value: "10",
                        ),
                        DropdownMenuItem(
                          child: Text("Nov"),
                          value: "11",
                        ),
                        DropdownMenuItem(
                          child: Text("Dec"),
                          value: "12",
                        ),
                      ],
                    ),
                  ),
                  FormField(
                    onSaved: (val) => _purchase["expiryYear"] = val,
                    builder: (state) => DropdownButton<String>(
                      value: _expiryYear,
                      onChanged: (val) => setState(() => _expiryYear = val),
                      items: ["2021", "2022", "2023", "2024"]
                          .map(
                              (y) => DropdownMenuItem(child: Text(y), value: y))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.payment),
        onPressed: () => _checkout(),
      ),
    );
  }
}
