import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pocket_piggy_bank/consts/app_text_styles/synopsis_text_style.dart';
import '../../../consts/app_colors.dart';
import '../../app/views/my_in_app_web_view.dart';
import '../widgets/ios_toggle.dart';
import '../widgets/settings_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isSwitched = false;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        title: const Text(
          'back',
          style: SynopsisTextStyle.back,
        ),
        titleSpacing: -5,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset('assets/icons/arrow.svg'),
        ),
      ),
      body: Container(
        color: AppColors.blackColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: size.height * 0.12,
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.darkGreyColor,
                  ),
                  child: Column(
                    children: [
                      SettingsTile(
                        assetName: 'assets/icons/currency_bold.svg',
                        text: 'Currency',
                        action: Row(
                          children: [
                            Text('USD'),
                            SvgPicture.asset('assets/icons/arrow_forward.svg')
                          ],
                        ),
                      ),
                      SettingsTile(
                        assetName: 'assets/icons/check.svg',
                        text: 'Safety',
                        action:
                            SvgPicture.asset('assets/icons/arrow_forward.svg'),
                      ),
                      SettingsTile(
                        assetName: 'assets/icons/bell.svg',
                        text: 'Notification',
                        action: IOSStyleToggle(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                            });
                          },
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.darkGreyColor,
                  ),
                  child: Column(
                    children: [
                      SettingsTile(
                        assetName: 'assets/icons/star.svg',
                        text: 'Currency',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyInAppWebView(
                                  url: 'https://google.com/'),
                            ),
                          );
                        },
                      ),
                      SettingsTile(
                        assetName: 'assets/icons/letter.svg',
                        text: 'Safety',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyInAppWebView(
                                  url: 'https://google.com/'),
                            ),
                          );
                        },
                      ),
                      SettingsTile(
                        assetName: 'assets/icons/doc.svg',
                        text: 'Privacy Policy',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyInAppWebView(
                                  url: 'https://google.com/'),
                            ),
                          );
                        },
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
