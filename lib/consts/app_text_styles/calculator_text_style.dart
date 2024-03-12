import 'package:flutter/material.dart';

import '../app_colors.dart';

class CalculatorTextStyle {
  static const TextStyle title = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 18.0,
    height: 22 / 18,
    fontWeight: FontWeight.w600,
    color: AppColors.darkGreyColor,
  );
  static const TextStyle preview = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 12.0,
    height: 18 / 12,
    fontWeight: FontWeight.w600,
    color: AppColors.darkGreyColor,
  );
  static const TextStyle date = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 12.0,
    height: 18 / 12,
    fontWeight: FontWeight.w400,
    color: AppColors.darkGreyColor,
  );
  static const TextStyle credit = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 18.0,
    height: 20 / 18,
    fontWeight: FontWeight.w600,
    //  color: AppColors.orangeColor,
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
