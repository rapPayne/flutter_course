import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllTheButtons extends StatefulWidget {
  const AllTheButtons({super.key});

  @override
  State<AllTheButtons> createState() => _AllTheButtonsState();
}

class _AllTheButtonsState extends State<AllTheButtons> {
  @override
  Widget build(BuildContext context) {
    return foo();
  }

  Widget foo() {
    Set<String> selectedValue = {};
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
            onPressed: () => {},
            child: const Text("TextButton"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: () => {},
            child: const Text("ElevatedButton"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: FloatingActionButton(
            onPressed: () => {},
            child: const Text("FAB"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SegmentedButton(
            emptySelectionAllowed: true,
            selected: selectedValue, // Tracks the currently selected value
            onSelectionChanged: (value) =>
                setState(() => selectedValue = value),
            segments: const [
              ButtonSegment(label: Text('Option 1'), value: 'option1'),
              ButtonSegment(label: Text('Option 2'), value: 'option2'),
              ButtonSegment(label: Text('Option 3'), value: 'option3'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CupertinoButton.filled(
            child: const Text("CupertinoButton"),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
