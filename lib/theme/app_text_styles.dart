import 'package:flutter/material.dart';

class AppTextStyles {
  static const headlineSemiBold = TextStyle(
    fontFamily: 'InterDisplay',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  static const bodyRegular = TextStyle(
    fontFamily: 'InterDisplay',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.01,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const medium12 = TextStyle(
    fontStyle: FontStyle.normal,
    fontFamily: 'InterDisplay',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.0,
  );

  static const medium14 = TextStyle(
    fontStyle: FontStyle.normal,
    fontFamily: 'InterDisplay',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.0,
    letterSpacing: 0.0,
  );

  static const regular14 = TextStyle(
    fontStyle: FontStyle.normal,
    fontFamily: 'InterDisplay',
    fontSize: 14,
  );
}
