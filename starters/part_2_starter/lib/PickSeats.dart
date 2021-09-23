import 'package:flutter/material.dart';
import 'Table.dart' as daamTable;

class PickSeats extends StatefulWidget {
  const PickSeats({Key? key}) : super(key: key);

  @override
  _PickSeatsState createState() => _PickSeatsState();
}

class _PickSeatsState extends State<PickSeats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick your seats"),
      ),
      body: Column(
        children: [
          Text("PickSeats"),
          daamTable.Table(), // <-- Note the "daamTable" prefix
          FloatingActionButton(
            child: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/checkout');
            },
          ),
        ],
      ),
    );
  }
}
