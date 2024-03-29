import 'package:ch_11_layout_the_scene/unbounded_height.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.red,
        ),
        debugShowCheckedModeBanner: false,
        home: const Scaffold(body: UnboundedHeight()),
      ),
    );
  }
}
