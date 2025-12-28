import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;
import 'package:template/presentation/base/theme/color_schema.dart'
    show colorSchemeProvider;
import 'package:template/presentation/base/theme/text_extension.dart'
    show customTextProvider;
import 'package:template/presentation/base/theme/text_theme.dart'
    show textThemeProvider;
import 'package:template/presentation/base/theme/theme_extension.dart'
    show customColorsProvider;

final themeDataProvider = Provider<ThemeData>((ref) {
  final scheme = ref.watch(colorSchemeProvider);
  final textTheme = ref.watch(textThemeProvider);
  final customColors = ref.watch(customColorsProvider);
  final customTexts = ref.watch(customTextProvider);

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    textTheme: textTheme,
    extensions: [customColors, customTexts],
  );
});
