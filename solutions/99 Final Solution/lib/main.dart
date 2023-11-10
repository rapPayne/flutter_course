import 'package:flutter/material.dart';
import 'Checkout.dart';
import 'FilmDetails.dart';
import 'Landing.dart';
import 'PickSeats.dart';
import 'Ticket.dart';
import 'state/SuperState.dart';
import 'state/AppState.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Customer customer = Customer()..email = "rap@creator.net";
    AppState state = AppState();
    state.customer = customer;
    return SuperStateWidget(
        state: state,
        child:
            // Consumer(builder: (context, watch, _) {
            //   return
            MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Reservations - Dinner And A Movie',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: "/",
          routes: {
            "/": (ctx) => Landing(),
            "/film": (ctx) => FilmDetails(),
            "/pickseats": (ctx) => PickSeats(),
            "/checkout": (ctx) => Checkout(),
            "/ticket": (ctx) => Ticket(),
          },
        )
        //}),
        ); // <-- ... and this
  }
}
// FilmDetails(
//           selected_date: DateTime.now(),
//           film: film,
//           showings: showings,
//         )
/*
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<Film> _films = [Film()];
  List<dynamic> _showings = [];

  void _incrementCounter() {
    fetchFilms().then((films) => this.setState(() => this._films = films));
    fetchShowings(film_id: 1, date: DateTime.now())
        .then((showings) => this.setState(() => this._showings = showings));
  }

  @override
  Widget build(BuildContext context) {
    _showings.forEach(
        (showing) => print(showing["showing_time"])); // <-- Add this line
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _films[0].title ?? "",
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/
