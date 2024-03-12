import 'package:flutter/material.dart';

class IntroductionWidget extends StatelessWidget {
  final String imagePath;

  const IntroductionWidget({
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
            Colors.white.withOpacity(1),
            BlendMode.dstATop,
          ),
        ),
      ),
    );
  }
}
