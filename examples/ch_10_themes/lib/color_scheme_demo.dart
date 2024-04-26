import 'package:flutter/material.dart';

class ColorSchemeDemo extends StatelessWidget {
  const ColorSchemeDemo({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

    return ListView(
      children: [
        _primaryDemo(cs, tt),
        _secondaryDemo(cs, tt),
        _tertiaryDemo(cs, tt),
        _errorDemo(cs, tt),
        _otherColorsDemo(cs, tt),
      ],
    );
  }

  Widget _primaryDemo(ColorScheme cs, TextTheme tt) {
    return Column(
      children: [
        ListTile(
          title: Text("Primary",
              style: tt.headlineSmall?.copyWith(color: cs.onPrimary)),
          tileColor: cs.primary,
        ),
        ListTile(
          title: Text("PrimaryContainer",
              style: tt.headlineSmall?.copyWith(color: cs.onPrimaryContainer)),
          tileColor: cs.primaryContainer,
        ),
      ],
    );
  }

  Widget _secondaryDemo(ColorScheme cs, TextTheme tt) {
    return Column(
      children: [
        ListTile(
          title: Text("secondary",
              style: tt.headlineSmall?.copyWith(color: cs.onSecondary)),
          tileColor: cs.secondary,
        ),
        ListTile(
          title: Text("secondaryContainer",
              style:
                  tt.headlineSmall?.copyWith(color: cs.onSecondaryContainer)),
          tileColor: cs.secondaryContainer,
        ),
      ],
    );
  }

  Widget _tertiaryDemo(ColorScheme cs, TextTheme tt) {
    return Column(
      children: [
        ListTile(
          title: Text("tertiary",
              style: tt.headlineSmall?.copyWith(color: cs.onTertiary)),
          tileColor: cs.tertiary,
        ),
        ListTile(
          title: Text("tertiaryContainer",
              style: tt.headlineSmall?.copyWith(color: cs.onTertiaryContainer)),
          tileColor: cs.tertiaryContainer,
        ),
      ],
    );
  }

  Widget _errorDemo(ColorScheme cs, TextTheme tt) {
    return Column(
      children: [
        ListTile(
          title: Text("error",
              style: tt.headlineSmall?.copyWith(color: cs.onError)),
          tileColor: cs.error,
        ),
        ListTile(
          title: Text("errorContainer",
              style: tt.headlineSmall?.copyWith(color: cs.onErrorContainer)),
          tileColor: cs.errorContainer,
        ),
      ],
    );
  }

  Widget _otherColorsDemo(ColorScheme cs, TextTheme tt) {
    return Column(
      children: [
        ListTile(
          title: Text("surface",
              style: tt.headlineSmall?.copyWith(color: cs.onSurface)),
          tileColor: cs.surface,
        ),
        ListTile(
          title: Text("inverseSurface",
              style: tt.headlineSmall?.copyWith(color: cs.onInverseSurface)),
          tileColor: cs.inverseSurface,
        ),
        ListTile(
          title: Text("surfaceVariant",
              style: tt.headlineSmall?.copyWith(color: cs.onSurfaceVariant)),
          tileColor: cs.surfaceVariant,
        ),
        ListTile(
          title: Text("outline",
              style: tt.headlineSmall?.copyWith(color: cs.outlineVariant)),
          tileColor: cs.outline,
        ),
      ],
    );
  }
}
