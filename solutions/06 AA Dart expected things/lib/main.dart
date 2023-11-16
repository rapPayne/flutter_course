// ignore_for_file: unnecessary_this, avoid_print

import 'package:flutter/material.dart';
import 'state/repository.dart';
import 'state/film.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _counter = 0;
  List<Film> _films = [Film()];
  List<dynamic> _showings = [];

  void _incrementCounter() {
    fetchFilms().then((films) => this.setState(() => this._films = films));
    fetchShowings(filmId: 1, date: DateTime.now())
        .then((showings) => this.setState(() => this._showings = showings));
    List<DateTime> dates = makeConsecutiveDates(5, DateTime.now());
    print(dates);
  }

  @override
  Widget build(BuildContext context) {
    for (dynamic showing in _showings) {
      print(showing["showing_time"]);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _films[0].title,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
