import 'package:flutter/material.dart';
import 'package:marvel/types/character_types.dart';

class CharacterCell extends StatelessWidget {
  const CharacterCell(this._character, {super.key});
  final Character _character;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/character', arguments: _character);
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              '${_character.thumbnail?.path}.${_character.thumbnail?.extension}',
              height: 100,
              width: 100,
            ),
          ),
          Text(
            _character.name ?? "",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
