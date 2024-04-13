import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class BunchOfWords extends StatelessWidget {
  BunchOfWords({super.key});

  final words = lorem(paragraphs: 1, words: 80)
      .replaceAll(RegExp(r'[^\w\s]'), '')
      .toLowerCase()
      .split(' ')
      .toList();
  // final List<String> words = [
  //   'tenus',
  //   'instanter',
  //   'pulchritudinis',
  //   'senectus',
  //   'praesto',
  //   'sumo',
  //   'calamitas',
  //   'peior',
  //   'nobis',
  //   'macero'
  // ];
  @override
  Widget build(BuildContext context) {
    var wordWidgets = words.map((w) => Word(w)).toList();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: wordWidgets,
      ),
    );
  }
}

class Word extends StatelessWidget {
  final String string;

  const Word(this.string, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        string,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
