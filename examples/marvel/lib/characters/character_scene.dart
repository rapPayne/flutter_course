import 'package:flutter/material.dart';
import 'package:marvel/characters/character.dart';
import 'package:marvel/comics/comics_list.dart';
import 'package:marvel/types/character_types.dart' as model;

class CharacterScene extends StatefulWidget {
  const CharacterScene({super.key});

  @override
  State<CharacterScene> createState() => _CharacterSceneState();
}

class _CharacterSceneState extends State<CharacterScene> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    model.Character character =
        ModalRoute.of(context)!.settings.arguments as model.Character;

    return Scaffold(
      appBar: AppBar(
        title: Text(character.name ?? ""),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: [
          const NavigationDestination(icon: Icon(Icons.abc), label: "Info"),
          NavigationDestination(
              icon: const Icon(Icons.abc),
              label: "Comics (${character.comics?.available})"),
          NavigationDestination(
              icon: const Icon(Icons.abc),
              label: "Stories (${character.series?.available})"),
          NavigationDestination(
              icon: const Icon(Icons.abc),
              label: "Events (${character.events?.available})"),
          NavigationDestination(
              icon: const Icon(Icons.abc),
              label: "Series (${character.series?.available})"),
        ],
        selectedIndex: _selectedTabIndex,
        onDestinationSelected: (i) => setState(() => _selectedTabIndex = i),
      ),
      body: [
        Character(character: character),
        ComicsList(characterId: character.id!),
        Text(character.stories?.collectionUri ?? ""),
        Text(character.events?.collectionUri ?? ""),
        Text(character.series?.collectionUri ?? ""),
      ][_selectedTabIndex],
    );
  }
}
