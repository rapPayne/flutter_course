// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'a.dart';
import 'b.dart';
import 'c.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirstNameService fns = FirstNameService();
    fns.first = "Initial value set on instantiation in main.dart";
    return TopWidget(
      firstNameService: fns,
      child: ListenableBuilder(
          listenable: fns,
          builder: (context, child) {
            print("Main builder is running?");

            return MaterialApp(
              title: 'State maintenance demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              routes: {
                '/a': (ctx) => A(foo: fns.first),
                '/b': (ctx) => const B(),
                '/c': (ctx) => const C(),
              },
              initialRoute: '/a',
            );
          }),
    );
  }
}

class FirstNameService extends ChangeNotifier {
  String first = "";

  void setFirst(String newFirst) {
    print("setFirst: $first => $newFirst");
    first = newFirst;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    print("notifying listeners $hasListeners");
    super.notifyListeners();
  }
}

class TopWidget extends InheritedWidget {
  final FirstNameService firstNameService;
  const TopWidget(
      {super.key, required this.firstNameService, required super.child});

  @override
  bool updateShouldNotify(covariant TopWidget oldWidget) {
    return true;
  }

  static TopWidget of(BuildContext context) {
    TopWidget? result = context.dependOnInheritedWidgetOfExactType<TopWidget>();
    assert(result != null,
        "No RootWidget found. Did you forget to wrap your main widget with one?");
    return result!;
  }
}
