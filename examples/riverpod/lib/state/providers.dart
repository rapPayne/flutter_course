import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_demo/models/person.dart';

final favNumberStateProvider = StateProvider<int>((ref) => 33);
final favColorStateProvider = StateProvider<Color>((ref) => Colors.red);

class PersonNotifier extends StateNotifier<Person> {
  PersonNotifier()
      : super(Person()
          ..first = "Becky"
          ..last = "Childers");
  setFirst(String newFirst) {
    return state..first = newFirst;
  }

  setLast(String newLast) => state..last = newLast;
  setAge(int newAge) => state..age = newAge;
}

final favPersonStateNotifierProvider =
    StateNotifierProvider<PersonNotifier, Person>((ref) => PersonNotifier());

final favPersonStateProvider = StateProvider<Person>((ref) => Person()
  ..first = "Ryan"
  ..last = "Woodall");
