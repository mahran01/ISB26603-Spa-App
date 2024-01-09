import 'package:flutter/material.dart';

ThemeData spaTheme() {
  final ThemeData base = ThemeData.light(useMaterial3: true);
  return base.copyWith(
    primaryColor: const Color(0xFF7165D6),
    colorScheme: base.colorScheme.copyWith(
      primary: const Color(0xFF7165D6),
    ),
    appBarTheme: base.appBarTheme.copyWith(
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFF7165D6),
    ),
  );
}
