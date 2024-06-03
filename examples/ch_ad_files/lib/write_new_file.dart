import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'layout_drawer.dart';
import 'utilities.dart';

class WriteNewFile extends StatefulWidget {
  const WriteNewFile({super.key});

  @override
  State<WriteNewFile> createState() => _WriteNewFileState();
}

class _WriteNewFileState extends State<WriteNewFile> {
  String _filename = 'newFile.txt';
  String _text = 'No text yet';
  String _message = '';
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
    final TextStyle messageStyle = _errorStatus
        ? const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)
        : Theme.of(context).textTheme.bodyMedium ?? const TextStyle();
    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: <Widget>[
          Text('Write a new file: $_filename'),
          TextField(
            decoration: const InputDecoration(labelText: 'Filename'),
            controller: _controller,
            onChanged: (String value) {
              setState(() {
                _filename = value;
              });
            },
          ),
          ElevatedButton(
            child: const Icon(Icons.open_in_browser),
            onPressed: () async {
              final Directory docs = await getApplicationDocumentsDirectory();
              setState(() {
                _errorStatus = false;
                _text = makeRandomText(50);
              });
              // Write the file
              try {
                final File file = File('${docs.path}/$_filename');
                await file.writeAsString(_text);
                // Modal success
                _message = '$_filename was saved with the message "$_text"';
              } catch (e) {
                _errorStatus = true;
                _message = 'Error: $e';
              } finally {
                setState(() {});
              }
            },
          ),
          Text(
            _text,
            style: const TextStyle(fontFamily: 'Courier'),
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
