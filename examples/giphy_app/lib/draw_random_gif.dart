// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class DrawRandomGif extends StatefulWidget {
  const DrawRandomGif({super.key});

  @override
  State<DrawRandomGif> createState() => _DrawRandomGifState();
}

class _DrawRandomGifState extends State<DrawRandomGif> {
  String? gifUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get a Random Gif"),
      ),
      body: Center(
        child: (gifUrl == null) ? Container() : Image.network(gifUrl!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchGif();
        },
        child: const Icon(Icons.arrow_back_ios_new),
      ),
    );
  }

  fetchGif() {
    print("Go fetch new Gif");
    var apiKey = dotenv.get("giphyApiKey");
    String url =
        'https://api.giphy.com/v1/gifs/random?api_key=$apiKey&tag=&rating=g';
    get(Uri.parse(url)).then((response) {
      Map<String, dynamic> body = json.decode(response.body);
      setState(() {
        gifUrl = body["data"]["images"]["original"]["url"];
        print(body["data"]["images"]["original"]["url"]);
      });
    }).catchError((error) {
      print("Error fetching, $error");
    });
  }
}
