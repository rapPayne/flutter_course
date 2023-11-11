import 'package:flutter/material.dart';

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
    return Column(
      children: [
        TextField(
          onChanged: (val) => _firstName = val,
          decoration: const InputDecoration(
            label: Text("First name"),
          ),
        ),
        TextField(
          onChanged: (val) => _lastName = val,
          decoration: const InputDecoration(
            label: Text("Last name"),
          ),
        ),
        TextField(
          onChanged: (val) => _email = val,
          decoration: const InputDecoration(
            label: Text("Email (optional)"),
            hintText: "you@yourEmail.com",
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        TextField(
          onChanged: (val) => _phone = val,
          decoration: const InputDecoration(
            label: Text("Cell (optional)"),
            hintText: "xxx-xxx-xxxx",
          ),
          keyboardType: TextInputType.phone,
        ),
        TextField(
          onChanged: (val) => _creditCardNumber = val,
          decoration: const InputDecoration(
            label: Text("Credit card"),
            hintText: "xxxx-xxxx-xxxx-xxxx",
          ),
          keyboardType: TextInputType.number,
        ),
        TextField(
          onChanged: (val) => _cvv = val,
          decoration: const InputDecoration(
            label: Text("CVV"),
            hintText: "Three-digit code on the back of the card",
          ),
          keyboardType: TextInputType.number,
        ),
        DropdownButton(
          value: _expiryMonth,
          items: _expiryMonths,
          onChanged: (val) => setState(() => _expiryMonth = val),
        ),
        DropdownButton(
          value: _expiryYear,
          items: _makeExpiryYears(),
          onChanged: (val) => setState(() => _expiryYear = val),
        ),
      ],
    );
  }

  void _checkout() {
    print(
        "For $_firstName $_lastName. ($_email $_phone) On card $_creditCardNumber ($_cvv) expires $_expiryMonth/$_expiryYear");
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
