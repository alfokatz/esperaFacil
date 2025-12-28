import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;

final colorSchemeProvider = Provider<ColorScheme>((ref) {
  return const ColorScheme(
    brightness: Brightness.light,

    // Primary
    primary: Color(0xFF97D700),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFEAF7CC),
    onPrimaryContainer: Color(0xFF0F1600),

    // Secondary
    secondary: Color(0xFF143D2E),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFF8DCEB6),
    onSecondaryContainer: Color(0xFF0F1600),

    // Error
    error: Color(0xFFFF1744),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFF66091B),
    onErrorContainer: Color(0xFFFFD1DA),

    // Surface & Background
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF0F1600),
    onSurfaceVariant: Color(0xFFACADAF),
    outline: Color(0xFF97D700),
    outlineVariant: Color(0xFF7A7B7D),

    // Fill in the rest with sensible defaults or your own choices:
    tertiary: Color(0xFF7A7B7D),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFD5D6D7),
    onTertiaryContainer: Color(0xFF0F1600),
    shadow: Color(0xFF000000),
    inverseSurface: Color(0xFF303030),
    onInverseSurface: Color(0xFFFFFFFF),
    inversePrimary: Color(0xFF80C400),
  );
});
