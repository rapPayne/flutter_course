import 'package:flutter/material.dart';
import 'layout_drawer.dart';

class LandingScene extends StatelessWidget {
  const LandingScene({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LayoutAppBar().toPreferredSizeWidget(context),
      drawer: const LayoutDrawer(),
      body: _greetingWidget,
    );
  }

  Widget get _greetingWidget {
    return const Text("Worked!");
  }
}
