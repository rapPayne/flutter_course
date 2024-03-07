import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/state/providers.dart';

class ChangeColor extends ConsumerStatefulWidget {
  const ChangeColor({super.key});

  @override
  ConsumerState<ChangeColor> createState() => _ChangeColorState();
}

class _ChangeColorState extends ConsumerState<ChangeColor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Color")),
      body: Column(
        children: [
          ColorPicker(
            pickerColor: ref.read(favColorStateProvider),
            onColorChanged: (newColor) {
              ref.read(favColorStateProvider.notifier).state = newColor;
            },
          ),
        ],
      ),
    );
  }
}
