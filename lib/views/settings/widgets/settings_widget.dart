import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_piggy_bank/consts/app_colors.dart';
import 'package:pocket_piggy_bank/consts/app_text_styles/synopsis_text_style.dart';

class SettingsTile extends StatelessWidget {
  final String assetName;
  final String text;
  final VoidCallback? onTap;
  final Widget? action;

  const SettingsTile({
    super.key,
    required this.assetName,
    required this.text,
    this.onTap,
    this.action,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(),
        child: Row(
          children: [
            SvgPicture.asset(
              assetName,
              width: 24.0,
              height: 24.0,
              color: AppColors.purpleColor,
            ),
            SizedBox(width: 16.0),
            Text(
              text,
              style: SynopsisTextStyle.tile,
            ),
            if (action != null) ...[
              Spacer(),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
