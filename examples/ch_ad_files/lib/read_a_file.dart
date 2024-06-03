import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'layout_drawer.dart';
import 'dart:io';

class ReadAFile extends StatefulWidget {
  const ReadAFile({super.key});

  @override
  State<ReadAFile> createState() => _ReadAFileState();
}

class _ReadAFileState extends State<ReadAFile> {
  String _filename = "newFile.txt";
  String _text = "No text yet";
  String _message = "";
  bool _errorStatus = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _filename);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LayoutAppBar().toPreferredSizeWidget(context),
      drawer: const LayoutDrawer(),
      body: _body,
    );
  }

  Widget get _body {
    TextStyle messageStyle = _errorStatus
        ? const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)
        : Theme.of(context).textTheme.bodyMedium ?? const TextStyle();
    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: <Widget>[
          Text("Reading from $_filename"),
          TextField(
            decoration: const InputDecoration(labelText: "Filename"),
            controller: _controller,
            onChanged: (value) {
              setState(() {
                _filename = value;
              });
            },
          ),
          ElevatedButton(
            child: const Icon(Icons.open_in_browser),
            onPressed: () async {
              Directory documents = await getApplicationDocumentsDirectory();
              _errorStatus = false;
              File file = File('${documents.path}/$_filename');
              try {
                String text = await file.readAsString();
                setState(() {
                  _text = text;
                  _message = '$_filename has this text inside it: "$_text"';
                });
              } catch (e) {
                setState(() {
                  _errorStatus = true;
                  _message = 'Error: $e';
                });
              }
            },
          ),
          Text(
            _text,
            style: const TextStyle(fontFamily: "Courier"),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: Text(
              _message,
              style: messageStyle,
            ),
          ),
        ],
      ),
    );
  }
}
