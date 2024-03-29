import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:marvel/characters/character_cell.dart';
import 'package:marvel/sensitive_constants.dart';
import 'package:marvel/types/character_types.dart';

class Lookup extends StatefulWidget {
  const Lookup({super.key});

  @override
  State<Lookup> createState() => _LookupState();
}

class _LookupState extends State<Lookup> {
  List<Character> _characters = [];
  final _key = GlobalKey<FormState>();
  Timer? _debounce;

  void fetchMarvelCharacters(String search) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      Uri uri = Uri.parse(
          'https://gateway.marvel.com:443/v1/public/characters?nameStartsWith=$search&apikey=$publicKey');
      get(uri)
          .then((res) => json.decode(res.body))
          .then((res) => MarvelRequest.fromJson(res))
          .then((res) => res.data)
          .then((res) => res.results)
          .then((characters) => setState(() => _characters = characters))
          .catchError(
              (err) => debugPrint("Error fetching character $search. $err"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Marvel Lookup")),
      body: Column(children: [
        // Input
        Form(
          autovalidateMode: AutovalidateMode.always,
          key: _key,
          child: TextFormField(
              decoration: const InputDecoration(
                labelText: "Who you want to see",
                hintText: "Hulk, Thor, Spider-man, etc.",
              ),
              onChanged: (val) {
                fetchMarvelCharacters(val);
              },
              validator: (val) {
                var re = RegExp(r'^[ a-zA-Z0-9().-]{3,}$');
                if (re.hasMatch(val ?? "")) return null;
                return "At least three letters plus - and . ";
              }),
        ),
        // List of characters
        Expanded(
          child: ListView(
            children:
                _characters.map<Widget>((char) => CharacterCell(char)).toList(),
          ),
        ),
      ]),
    );
  }
}
