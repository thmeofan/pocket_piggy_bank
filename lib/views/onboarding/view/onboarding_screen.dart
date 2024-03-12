import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/onboarding_cubit/onboarding_cubit.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/onboarding_text_style.dart';
import '../../../util/app_routes.dart';
import '../../app/widgets/chosen_action_button_widget.dart';
import '../widgets/introduction_widget.dart';

class OnboardingScreen extends StatefulWidget {
  final bool? isFirstTime;

  const OnboardingScreen({
    Key? key,
    this.isFirstTime,
  }) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final CarouselController _carouselController = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      //  extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        // color: AppColors.blackColor,
        child: Column(
          children: [
            Expanded(
              child: CarouselSlider(
                items: const [
                  IntroductionWidget(
                    imagePath: 'assets/images/onboarding1.png',
                  ),
                  IntroductionWidget(
                    imagePath: 'assets/images/onboarding2.png',
                  ),
                ],
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: size.height * 0.6,
                  autoPlay: false,
                  //  enlargeCenterPage: true,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(3, (index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  width:
                      _current == index ? size.width * 0.2 : size.width * 0.1,
                  height: size.width * 0.02,
                  margin: const EdgeInsets.symmetric(
                      vertical: 1.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(size.width * 0.01),
                    color:
                        _current == index ? AppColors.blueColor : Colors.white,
                  ),
                );
              }),
            ),
            Padding(
              padding: EdgeInsets.all(size.height * 0.02),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Flexible(
                    child: Text(
                      _current == 0 ? 'Save money' : 'Check your wallet',
                      style: OnboardingTextStyle.description,
                      textAlign: TextAlign.start,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Flexible(
                    child: Text(
                      _current == 0
                          ? 'Control your money in one place'
                          : 'In our app you can track your spendings and incomes',
                      style: OnboardingTextStyle.description,
                      textAlign: TextAlign.start,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  const Spacer(),
                  ChosenActionButton(
                    onTap: () async {
                      context.read<OnboardingCubit>().setFirstTime();
                      Navigator.pushReplacementNamed(context, AppRoutes.home);
                    },
                    text: 'Continue',
                  ),
                  SizedBox(
                    height: size.height * 0.035,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
