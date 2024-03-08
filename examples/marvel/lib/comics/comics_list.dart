import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:marvel/sensitiveConstants.dart';
import 'package:marvel/types/comics_types.dart';
import 'package:marvel/utils/utilities.dart';

class ComicsList extends StatefulWidget {
  const ComicsList({required this.characterId, super.key});
  final int characterId;

  @override
  State<ComicsList> createState() => _ComicsListState();
}

class _ComicsListState extends State<ComicsList> {
  List<Comic> _comics = [];

  @override
  void initState() {
    // int timeStamp = DateTime.now().millisecondsSinceEpoch;
    // String hash = generateMd5('$timeStamp$privateKey$publicKey');

    var uriString =
        'https://gateway.marvel.com:443/v1/public/comics?characters=${widget.characterId}';
    var uri = Uri.parse('$uriString&apikey=$publicKey');

    get(uri)
        .then((res) => json.decode(res.body))
        .then((res) => ComicsRequest.fromJson(res))
        .then((res) => res.data)
        .then((res) => res?.results)
        .then((comics) => setState(() => _comics = comics!))
        .catchError((err) {
      debugPrint("Error fetching comics $err");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _comics
          .map((comic) => Image.network(getImagePath(comic.images?[0])))
          .toList(),
    );
  }
}

String getImagePath(Thumbnail? image) {
  return '${image?.path ?? ""}.jpg';
}
