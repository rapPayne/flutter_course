import 'package:flutter/material.dart';
import 'package:marvel/types/character_types.dart' as model;

class Character extends StatelessWidget {
  const Character({super.key, required this.character});
  final model.Character character;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.network(
            //'${character["thumbnail"]["path"]}.${character["thumbnail"]["extension"]}',
            '${character.thumbnail?.path}.${character.thumbnail?.extension}',
          ),
          if (character.description != null) Text(character.description!),
        ],
      ),
    );
  }
}
