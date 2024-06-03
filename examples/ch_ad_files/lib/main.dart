import 'package:flutter/material.dart';
import 'change_user_preferences.dart';
import 'json_reading_and_writing.dart';
import 'landing_scene.dart';
import 'read_a_file.dart';
import 'read_assets_file.dart';
import 'write_new_file.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appendix D Your Flutter app can work with files',
      theme: ThemeData(primarySwatch: Colors.red),
      routes: <String, WidgetBuilder>{
        '/': (BuildContext ctx) => const LandingScene(),
        '/changingUserPreferences': (BuildContext ctx) =>
            const ChangeUserPreferences(),
        '/jsonReadingAndWriting': (BuildContext ctx) =>
            const JsonReadingAndWriting(),
        '/readAssetsFile': (BuildContext ctx) => const ReadAssetsFile(),
        '/readAFile': (BuildContext ctx) => const ReadAFile(),
        '/writeNewFile': (BuildContext ctx) => const WriteNewFile(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
