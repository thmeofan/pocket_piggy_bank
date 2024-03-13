import 'package:flutter/material.dart';

import '../app_colors.dart';

class FinanceTextStyle {
  static TextStyle input = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14.0,
    height: 20 / 18,
    fontWeight: FontWeight.w400,
    color: Colors.white.withOpacity(0.6),
  );
  static TextStyle output = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14.0,
    height: 20 / 18,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
  static TextStyle subtitle = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14.0,
    height: 24 / 20,
    fontWeight: FontWeight.w800,
    color: Colors.white.withOpacity(0.25),
  );
  static TextStyle bannerTitles = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14.0,
    height: 20 / 18,
    fontWeight: FontWeight.w600,
    color: Colors.white.withOpacity(0.55),
  );
  static const TextStyle date = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 12.0,
    height: 20 / 14,
    fontWeight: FontWeight.w800,
    color: Colors.white,
  );
  static const TextStyle tileSumIn = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 20.0,
    height: 20 / 18,
    fontWeight: FontWeight.w600,
    color: AppColors.greenColor,
  );
  static const TextStyle tileSumSp = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 20.0,
    height: 20 / 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static const TextStyle tileTitle = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 15.0,
    height: 20 / 14,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  static TextStyle tileSubitle = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 12.0,
    height: 20 / 14,
    fontWeight: FontWeight.w300,
    color: Colors.white.withOpacity(0.5),
  );
}
