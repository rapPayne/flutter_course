import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'layout_drawer.dart';

class ReadAssetsFile extends StatefulWidget {
  const ReadAssetsFile({super.key});

  @override
  State<ReadAssetsFile> createState() => _ReadAssetsFileState();
}

class _ReadAssetsFileState extends State<ReadAssetsFile> {
  final String _text = "No text yet";
  String _message = "";
  bool _errorStatus = false;

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
          ElevatedButton(
            child: const Icon(Icons.open_in_browser),
            onPressed: () async {
              _errorStatus = false;
              try {
                _message = await rootBundle.loadString('assets/database.json');
              } catch (e) {
                _errorStatus = true;
                _message = 'Error: $e';
              }
              setState(() {});
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
