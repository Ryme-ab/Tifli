import 'package:flutter/material.dart';

class AppFonts {
  // Font family names (must match pubspec.yaml)
  static const String primaryFont = "OpenSans";
  static const String secondaryFont = "Afacad";

  // Common text styles
  static const TextStyle heading1 = TextStyle(
    fontFamily: primaryFont,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: primaryFont,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle body = TextStyle(
    fontFamily: secondaryFont,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle small = TextStyle(
    fontFamily: secondaryFont,
    fontSize: 12,
    color: Colors.grey,
  );
}
