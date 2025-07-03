import 'package:flutter/material.dart';

class AppColors {
  static const primaryBlack = Color(0xFF000000);
  static const primaryWhite = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFF404040);
  static const scaffoldBackground = Color(0xFFF3F3F3);

  static LinearGradient nutrientGradientFromColor(Color color) {
    return LinearGradient(
      colors: [color.withValues(alpha: 0.2), color.withValues(alpha: 0.0)],
      stops: [0.0, 1.0],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );
  }
}
