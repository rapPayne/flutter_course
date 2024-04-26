import 'package:ch_10_themes/color_scheme_demo.dart';
import 'package:ch_10_themes/text_theme_demo.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({required this.title, super.key});
  final String title;
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: _currentIndex,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
        ),
        body: TabBarView(
          children: [
            _dashboard(context),
            const ColorSchemeDemo(),
            const TextThemeDemo(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (i) => setState(() => _currentIndex = i),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard), label: "Dashboard"),
            BottomNavigationBarItem(
                icon: Icon(Icons.font_download), label: "Text Theme"),
            BottomNavigationBarItem(
                icon: Icon(Icons.color_lens), label: "Color Scheme"),
          ],
        ),
      ),
    );
  }

  Widget _dashboard(context) {
    ThemeData myTheme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'You pushed the button this many times:',
          ),
          Text(
            '12',
            style: myTheme.textTheme.headlineMedium,
          ),
          const TextField(
            decoration: InputDecoration(
                helperText: "Type something here",
                labelText: "This is a text field",
                errorText: null),
          ),
          const TextField(
            decoration: InputDecoration(
                helperText: "This is helper text",
                labelText: "This is another text field",
                errorText: null),
          ),
          const ListTile(
            isThreeLine: true,
            title: Text("I'm the title"),
            subtitle: Text("I'm the subtitle"),
          ),
          const Chip(label: Text("CHIP")),
          ElevatedButton(
            onPressed: () {},
            child: const Text("ElevatedButton"),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("TextButton"),
          ),
          FloatingActionButton(
            onPressed: () {},
            child: const Text("FAB"),
          ),
        ],
      ),
    );
  }
}
