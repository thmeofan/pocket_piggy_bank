import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../consts/app_colors.dart';
import '../../../data/models/news_model.dart';
import '../../currency/views/currency_screen.dart';
import '../../finance/views/finance_screen.dart';
import '../../news/views/news_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> homeWidgets = [
    FinanceScreen(),
    NewsScreen(
      newsModel: news,
    ),
    CurrencyScreen(),

    // const SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: homeWidgets[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              width: size.height * 0.032,
              height: size.height * 0.032,
              color: currentIndex == 0
                  ? AppColors.purpleColor
                  : AppColors.darkGreyColor,
            ),
            label: 'Finance',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/activity.svg',
              width: size.height * 0.032,
              height: size.height * 0.032,
              color: currentIndex == 1
                  ? AppColors.purpleColor
                  : AppColors.darkGreyColor,
            ),
            label: 'News',
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/statistics.svg',
                width: size.height * 0.032,
                height: size.height * 0.032,
                color: currentIndex == 2
                    ? AppColors.purpleColor
                    : AppColors.darkGreyColor,
              ),
              label: 'Currency'),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedItemColor: AppColors.purpleColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
