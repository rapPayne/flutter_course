import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/state/providers.dart';

class ChangeNumber extends ConsumerStatefulWidget {
  const ChangeNumber({super.key});

  @override
  ConsumerState<ChangeNumber> createState() => _ChangeNumberState();
}

class _ChangeNumberState extends ConsumerState<ChangeNumber> {
  @override
  Widget build(BuildContext context) {
    int favNumber = ref.watch(favNumberStateProvider);

    return Column(
      children: [
        Slider(
          value: favNumber.toDouble(),
          min: 0,
          max: 100,
          divisions: 100,
          label: favNumber.toString(),
          onChanged: (val) {
            ref.read(favNumberStateProvider.notifier).state = val.toInt();
          },
        ),
      ],
    );
  }
}
