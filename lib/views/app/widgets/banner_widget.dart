
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/synopsis_text_style.dart';
import '../../../util/app_routes.dart';

class OperationBanner extends StatelessWidget {
  const OperationBanner({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.height * 0.01),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 2,
              blurRadius: 4,
            ),
          ],
          borderRadius: BorderRadius.circular(25),
          color: AppColors.darkGreyColor,
        ),
        width: size.width * 0.95,
        height: size.height * 0.17,
        child: Row(
          children: [
            Image.asset(
              'assets/images/currency_crush_coins.png',
              fit: BoxFit.contain,
              width: size.width * 0.4,
              height: size.height * 0.12,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(children: [
                SizedBox(height: size.height * 0.02),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/wallet.svg'),
                    SizedBox(width: size.width * 0.02),
                    const Text(
                      'Ваши доходы',
                      style: SynopsisTextStyle.banner,
                    ),
                    SizedBox(width: size.width * 0.02),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.operation);
                      },
                      icon: SvgPicture.asset(
                          'assets/icons/chevron-arrow-left.svg'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/wallet.svg'),
                    SizedBox(width: size.width * 0.02),
                    const Text(
                      'Ваши расходы',
                      style: SynopsisTextStyle.banner,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.operation);
                      },
                      icon: SvgPicture.asset(
                          'assets/icons/chevron-arrow-left.svg'),
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
