import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/profile_text_style.dart';
import '../../../consts/app_text_styles/synopsis_text_style.dart';
import '../../app/views/my_in_app_web_view.dart';

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
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Settings',
          style: SynopsisTextStyle.appbar,
        ),
        actions: [
          IconButton(
            iconSize: 24,
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/profile.svg'),
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/icons/profile.svg',
                height: size.height * 0.13,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              const Text(
                'Имя Пользователя',
                textAlign: TextAlign.center,
                style: ProfileTextStyle.user,
                // controller: _nameController,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              const Text(
                'username@gmail.com',
                textAlign: TextAlign.center,
                style: ProfileTextStyle.email,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              ListTile(
                // tileColor: AppColors.lightGreyColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MyInAppWebView(url: 'https://google.com/'),
                        ),
                      );
                    },
                    style: const ButtonStyle(alignment: Alignment.centerLeft),
                    icon: SvgPicture.asset(
                      'assets/icons/lock.svg',
                      width: 26,
                      height: 26,
                    ),
                    label: const Text(
                      'Политика конфиденциальности',
                      style: ProfileTextStyle.tile,
                    )),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              ListTile(
                //  tileColor: AppColors.lightGreyColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MyInAppWebView(url: 'https://google.com/'),
                        ),
                      );
                    },
                    style: const ButtonStyle(alignment: Alignment.centerLeft),
                    icon: SvgPicture.asset(
                      'assets/icons/like-thumb_up.svg',
                      width: 26,
                      height: 26,
                    ),
                    label: const Text(
                      'Оценить приложение',
                      style: ProfileTextStyle.tile,
                    )),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              ListTile(
                // tileColor: AppColors.lightGreyColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MyInAppWebView(url: 'https://google.com/'),
                        ),
                      );
                    },
                    style: const ButtonStyle(alignment: Alignment.centerLeft),
                    icon: SvgPicture.asset(
                      'assets/icons/link-url.svg',
                      width: 26,
                      height: 26,
                    ),
                    label: const Text(
                      'Поделиться приложением',
                      style: ProfileTextStyle.tile,
                    )),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              ListTile(
                //  tileColor: AppColors.lightGreyColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MyInAppWebView(url: 'https://google.com/'),
                        ),
                      );
                    },
                    style: const ButtonStyle(alignment: Alignment.centerLeft),
                    icon: SvgPicture.asset(
                      'assets/icons/info.svg',
                      width: 26,
                      height: 26,
                    ),
                    label: const Text(
                      'Условия использования',
                      style: ProfileTextStyle.tile,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
