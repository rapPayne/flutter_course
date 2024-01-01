// ignore_for_file: unused_field
import 'dart:convert';
import 'package:daam/state/global.dart';
import 'package:daam/state/repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phone;
  String? _creditCardNumber;
  String? _cvv;
  String? _expiryMonth;
  String? _expiryYear;
  final GlobalKey<FormState> _key = GlobalKey();
  final Map<String, dynamic> _purchase = global.get("cart");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text("Checkout"),
            const Text("Your cart"),
            // ignore: avoid_unnecessary_containers
            Container(
              child: const Text("Cart will go here"),
            ),
            _makeCheckoutForm(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.payment),
        onPressed: () => _checkout(),
      ),
    );
  }

  Widget _makeCheckoutForm() {
    return Form(
      key: _key,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              label: Text("First name"),
            ),
            onChanged: (val) => _firstName = val,
            onSaved: (val) => _purchase["firstName"] = val,
            validator: (val) => val == null || val.isEmpty ? "Required" : null,
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Last name"),
            ),
            onChanged: (val) => _lastName = val,
            onSaved: (val) => _purchase["lastName"] = val,
            validator: (val) => val == null || val.isEmpty ? "Required" : null,
          ),
          TextFormField(
              decoration: const InputDecoration(
                label: Text("Email (optional)"),
                hintText: "you@yourEmail.com",
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (val) => _email = val,
              onSaved: (val) => _purchase["email"] = val,
              validator: (val) {
                if ((val == null || val.isEmpty) &&
                    (_phone == null || _phone!.isEmpty)) {
                  return "We need an email or a phone";
                } else {
                  return null;
                }
              }),
          TextFormField(
              decoration: const InputDecoration(
                label: Text("Cell (optional)"),
                hintText: "xxx-xxx-xxxx",
              ),
              keyboardType: TextInputType.phone,
              onChanged: (val) => _phone = val,
              onSaved: (val) => _purchase["phone"] = val,
              validator: (val) {
                if ((val == null || val.isEmpty) &&
                    (_email == null || _email!.isEmpty)) {
                  return "We need an email or a phone";
                } else {
                  return null;
                }
              }),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Credit card"),
              hintText: "xxxx-xxxx-xxxx-xxxx",
            ),
            keyboardType: TextInputType.number,
            onChanged: (val) => _creditCardNumber = val,
            onSaved: (val) => _purchase["creditCardNumber"] = val,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Required";
              }
              RegExp regex = RegExp(r'^(\d{4}[- ]?){4}$');
              if (!regex.hasMatch(val)) {
                return "Credit cards have 13 to 16 digits and spaces or dashes";
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("CVV"),
              hintText: "Three-digit code on the back of the card",
            ),
            keyboardType: TextInputType.number,
            onChanged: (val) => _cvv = val,
            onSaved: (val) => _purchase["CVV"] = val,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Required";
              }
              RegExp regex = RegExp(r'^\d{3}$');
              if (!regex.hasMatch(val)) {
                return "Must be three digits";
              }
              return null;
            },
          ),
          DropdownButtonFormField(
            value: _expiryMonth,
            items: _expiryMonths,
            decoration: const InputDecoration(
              label: Text("Expiry month"),
            ),
            onChanged: (val) => setState(() => _expiryMonth = val),
            onSaved: (val) => _purchase["expiryMonth"] = val,
            validator: (val) => _validateExpiry(),
          ),
          DropdownButtonFormField(
            value: _expiryYear,
            items: _makeExpiryYears(),
            decoration: const InputDecoration(
              label: Text("Expiry year"),
            ),
            onChanged: (val) => setState(() => _expiryYear = val),
            onSaved: (val) => _purchase["expiryYear"] = val,
            validator: (val) => _validateExpiry(),
          ),
        ],
      ),
    );
  }

  void _checkout() {
    if (_key.currentState == null) return;
    if (!_key.currentState!.validate()) return;
    _key.currentState?.save();
    var purchaseJson = json.encode(_purchase);
    var url = '${getBaseUrl()}/api/buyTickets';
    var uri = Uri.parse(url);
    var headers = {'Content-Type': 'application/json'};
    post(uri, body: purchaseJson, headers: headers).then((res) {
      var ticketNumbers = (json.decode(res.body) as List).cast<int>();
      global.set("ticketNumbers", ticketNumbers);
      Navigator.pushNamed(context, "/ticket");
    }).catchError((e) {
      //TODO: Respond to the error somehow
    });
  }

  String? _validateExpiry() {
    if (_expiryMonth == null || _expiryYear == null) {
      return "Expiry date is required";
    }
    DateTime expiryDate =
        DateTime(int.parse(_expiryYear!), int.parse(_expiryMonth!));

    if (expiryDate.isAfter(DateTime.now())) {
      return null;
    } else {
      return "The card is expired";
    }
  }

  final List<DropdownMenuItem> _expiryMonths = [
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

  List<DropdownMenuItem> _makeExpiryYears() {
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
