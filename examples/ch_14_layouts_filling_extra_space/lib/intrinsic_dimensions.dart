import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: const Text('IntrinsicWidth and IntrinsicHeight Example')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: Colors.blue,
                    width: 100,
                    child: const Text('Box 1'),
                  ),
                  Container(
                    color: Colors.green,
                    width: 150,
                    child: const Text('Box 2\nwith\nmultiple\nlines'),
                  ),
                  Container(
                    color: Colors.orange,
                    width: 75,
                    child: const Text('Box 3'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: Colors.purple,
                    child: const Text(
                        'This is a really long text that should wrap to multiple lines'),
                  ),
                  Container(
                    color: Colors.red,
                    child: const Text('Short text'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
