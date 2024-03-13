import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_piggy_bank/consts/app_colors.dart';

class IntroductionPNGWidget extends StatelessWidget {
  final String imagePath;

  const IntroductionPNGWidget({
    key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.4,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(
            AppColors.blackColor.withOpacity(1),
            BlendMode.dstATop,
          ),
        ),
      ),
    );
  }
}
