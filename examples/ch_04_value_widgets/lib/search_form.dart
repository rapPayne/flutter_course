import 'package:flutter/material.dart';

class SearchForm extends StatefulWidget {
  const SearchForm({super.key});

  @override
  State<SearchForm> createState() => _SearchFormState();
}

enum SearchLocation { anywhere, title, text }

enum SearchType { web, image, news, shopping }

class _SearchFormState extends State<SearchForm> {
  /*
  Showing how a Form ties all its fields together.

  Let’s say that we wanted to create a scene for the user to submit a 
  Google-like web search. We’ll give them a TextFormField for the search 
  String, a DropdownButtonFormField with the type of search, a Radio group for
  the search location and a button to submit:

  Pretend that after the user submits their search criteria, we want to save it 
  to our DB for marketing reasons. So on submit, we save it to a private 
  property called _dbRecord and then send it to our server.

  We'll do all that in the _key.currentState.save() after validating each field.

  SearchLocation from a Radio group
  SearchType from a DropDownButton
  numberOfResults from a Slider
  searchString from a TextFormField

  */
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _dbRecord = {};
  String _searchString = '';
  SearchLocation? _searchLocation;
  int _numberOfResults = 10;
  SearchType? _searchType = SearchType.web;

  @override
  Widget build(BuildContext context) {
    //Other code goes here
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Form"),
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Column(children: [
            searchBox,
            radioGroup,
            slider,
            dropdown,
            submitButton,
          ]),
        ),
      ),
    );
  }

  Widget get submitButton {
    return ElevatedButton(
      onPressed: () {
        debugPrint("Search string: $_searchString");
        debugPrint("Location: $_searchLocation");
        debugPrint("SearchType: $_searchType");
        debugPrint("Number of results: $_numberOfResults");
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
        }
      },
      child: const Text("Submit"),
    );
  }

  Widget get searchBox {
    return TextFormField(
      onSaved: (val) => _searchString = val ?? "",
      validator: _searchBoxValidator,
    );
  }

  Widget get radioGroup {
    return FormField<SearchLocation>(
      onSaved: (newValue) => _dbRecord["location"] = newValue,
      validator: _searchLocationValidator,
      builder: (FormFieldState s) {
        return Column(
          children: [
            Radio(
                groupValue: _searchLocation,
                value: SearchLocation.anywhere,
                onChanged: (val) => setState(() => _searchLocation = val)),
            const Text('Search anywhere'),
            Radio(
                groupValue: _searchLocation,
                value: SearchLocation.text,
                onChanged: (val) => setState(() => _searchLocation = val)),
            const Text('Search page text'),
            Radio(
                groupValue: _searchLocation,
                value: SearchLocation.title,
                onChanged: (val) => setState(() => _searchLocation = val)),
            const Text('Search page title'),
          ],
        );
      },
    );
  }

  Widget get slider {
    return FormField<int>(
      onSaved: (val) => _dbRecord["numberOfResults"] = val,
      validator: _numberOfResultsValidator,
      builder: (s) => Slider(
        label: _numberOfResults.toString(),
        min: 0.0,
        max: 100.0,
        divisions: 100,
        value: _numberOfResults.toDouble(),
        onChanged: (val) {
          setState(() => _numberOfResults = val.round());
        },
      ),
    );
  }

  Widget get dropdown {
    return DropdownButtonFormField<SearchType>(
      onChanged: (val) => _searchType = val,
      onSaved: (val) => _dbRecord["searchType"] == val,
      validator: _searchTypeValidator,
      value: _searchType,
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
    );
  }

  String? _searchBoxValidator(String? val) {
    return (val == null || val.isEmpty)
        ? "We need something to search for"
        : null;
  }

  String? _searchLocationValidator(SearchLocation? val) {
    return (val == null) ? "Please choose a location" : null;
  }

  String? _numberOfResultsValidator(int? val) {
    if (val! < 0) {
      return "We need a positive number";
    } else if (val > 1000) {
      return "That number is too big";
    } else {
      return null;
    }
  }

  String? _searchTypeValidator(SearchType? val) {
    return (val == null) ? "Please choose a search type" : null;
  }
}
