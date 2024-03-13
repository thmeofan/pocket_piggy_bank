import 'package:flutter/material.dart';

import '../app_colors.dart';

class CurrencyTextStyle {
  static TextStyle rowTitle = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 13.0,
    height: 22 / 18,
    fontWeight: FontWeight.w600,
    color: Colors.white.withOpacity(0.4),
  );
  static TextStyle rowInput = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14.0,
    height: 22 / 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static const TextStyle rowDropDown = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14.0,
    height: 18 / 12,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  static const TextStyle tableTitles = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14.0,
    height: 18 / 12,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  static const TextStyle tableLine = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 18.0,
    height: 18 / 12,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  static const TextStyle detailTitle = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 18.0,
    height: 20 / 18,
    fontWeight: FontWeight.w800,
    color: AppColors.darkGreyColor,
  );
  static const TextStyle numbers = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 14.0,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
    color: AppColors.darkGreyColor,
  );
}
