import 'package:flutter/material.dart';

class TextThemeDemo extends StatelessWidget {
  const TextThemeDemo({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme t = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Table(
          defaultColumnWidth: const IntrinsicColumnWidth(),
          children: [
            TableRow(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 2.0, color: Colors.black))),
                children: [
                  Text("bodySmall", style: t.bodySmall),
                  Text("bodyMedium", style: t.bodyMedium),
                  Text("bodyLarge", style: t.bodyLarge),
                ]),
            TableRow(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 2.0, color: Colors.black))),
                children: [
                  Text("labelSmall", style: t.labelSmall),
                  Text("labelMedium", style: t.labelMedium),
                  Text("labelLarge", style: t.labelLarge),
                ]),
            TableRow(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 2.0, color: Colors.black))),
                children: [
                  Text("titleSmall", style: t.titleSmall),
                  Text("titleMedium", style: t.titleMedium),
                  Text("titleLarge", style: t.titleLarge),
                ]),
            TableRow(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 2.0, color: Colors.black))),
                children: [
                  Text("headlineSmall", style: t.headlineSmall),
                  Text("headlineMedium", style: t.headlineMedium),
                  Text("headlineLarge", style: t.headlineLarge),
                ]),
            TableRow(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 2.0, color: Colors.black))),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text("displaySmall", style: t.displaySmall),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text("displayMedium", style: t.displayMedium),
                  ),
                  Text("displayLarge", style: t.displayLarge),
                ]),
          ],
        )
      ],
    );
  }
}
