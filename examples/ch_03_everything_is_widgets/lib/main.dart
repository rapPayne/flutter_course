// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Person(firstName: "Sarah", lastName: "Ali");
  }
}

class Person extends StatelessWidget {
  final String firstName;
  final String lastName;
  const Person({this.firstName = "", this.lastName = ""});
  @override
  Widget build(BuildContext context) {
    return Text('$firstName $lastName');
  }
}

class FancyHelloWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("A fancier app"),
        ),
        body: Container(
          alignment: Alignment.center,
          child: const Text("Hello world"),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.thumb_up),
          onPressed: () => {},
        ),
      ),
    );
  }
}
