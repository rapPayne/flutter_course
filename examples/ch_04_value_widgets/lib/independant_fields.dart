import 'package:flutter/material.dart';

class IndependantFields extends StatefulWidget {
  const IndependantFields({super.key});

  @override
  State<IndependantFields> createState() => _IndependantFieldsState();
}

enum SearchLocation { anywhere, title, text }

enum SearchType { web, image, news, shopping }

class _IndependantFieldsState extends State<IndependantFields> {
  SearchLocation? searchLocation;
  int numberOfResults = 10;
  SearchType? searchType = SearchType.web;

  @override
  Widget build(BuildContext context) {
    //Other code goes here
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Form"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          radioGroup,
          slider,
          dropdown,
          submitButton,
        ]),
      ),
    );
  }

  Widget get submitButton {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              debugPrint("Location: $searchLocation");
              debugPrint("SearchType: $searchType");
              debugPrint("Number of results: $numberOfResults");
            },
            child: const Text("Submit"))
      ],
    );
  }

  Widget get radioGroup {
    return Column(
      children: [
        Radio(
            groupValue: searchLocation,
            value: SearchLocation.anywhere,
            onChanged: (val) => setState(() => searchLocation = val)),
        const Text('Search anywhere'),
        Radio(
            groupValue: searchLocation,
            value: SearchLocation.text,
            onChanged: (val) => setState(() => searchLocation = val)),
        const Text('Search page text'),
        Radio(
            groupValue: searchLocation,
            value: SearchLocation.title,
            onChanged: (val) => setState(() => searchLocation = val)),
        const Text('Search page title'),
      ],
    );
  }

  Widget get slider {
    return Slider(
      label: numberOfResults.toString(),
      min: 0.0,
      max: 100.0,
      divisions: 100,
      value: numberOfResults.toDouble(),
      onChanged: (val) {
        setState(() => numberOfResults = val.round());
      },
    );
  }

  Widget get dropdown {
    return DropdownButton(
      value: searchType,
      items: const [
        DropdownMenuItem(
          value: SearchType.web,
          child: Text('Web'),
        ),
        DropdownMenuItem(
          value: SearchType.image,
          child: Text('Image'),
        ),
        DropdownMenuItem(
          value: SearchType.news,
          child: Text('News'),
        ),
        DropdownMenuItem(
          value: SearchType.shopping,
          child: Text('Shopping'),
        ),
      ],
      onChanged: (SearchType? val) => searchType = val,
    );
  }
}
