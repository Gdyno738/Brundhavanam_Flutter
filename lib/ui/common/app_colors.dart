import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  /// Primary Brand Colors
  static const Color primary = Color(0xFF049150);
  static const Color primaryLight = Color(0xFF05A25A);
  static const Color primaryDark = Color(0xFF037D44);

  /// Basic Colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Color(0xFF9E9E9E);
  static const Color lightGrey = Color(0xFFE0E0E0);

  /// Backgrounds
  static const Color scaffoldBackground = white;

  /// Shadows & Overlay (FIXED)
  static Color shadow = black.withValues(alpha: 0.15);
  static Color glossWhite = white.withValues(alpha: 0.08);
  static Color glossBlack = black.withValues(alpha: 0.05);


}
