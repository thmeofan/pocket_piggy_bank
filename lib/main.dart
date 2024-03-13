import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocket_piggy_bank/util/app_routes.dart';
import 'package:pocket_piggy_bank/views/app/views/screen_new.dart';
import 'data/repository/onboarding_repository.dart';
import 'firebase_options.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeFirebase();
  String privacyPolicyLink = await fetchPrivacyPolicyLink();
  bool isFirstTime = await checkFirstLaunch();

  runApp(MyApp(
    isFirstLaunch: isFirstTime,
    privacyPolicyLink: privacyPolicyLink,
  ));
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<String> fetchPrivacyPolicyLink() async {
  FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.fetchAndActivate();
  return remoteConfig.getString('test1');
}

Future<bool> checkFirstLaunch() async {
  bool isFirstTime = await OnboardingRepository().checkFirstTime();

  return isFirstTime;
}

class MyApp extends StatelessWidget {
  const MyApp(
      {Key? key, required this.isFirstLaunch, required this.privacyPolicyLink})
      : super(key: key);

  final bool isFirstLaunch;
  final String privacyPolicyLink;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple),
      onGenerateRoute: (settings) {
        if (privacyPolicyLink.isNotEmpty && privacyPolicyLink != 'haveNoLink') {
          return MaterialPageRoute(builder: (context) => const ScreenNew());
        } else {
          return AppRoutes.onGenerateRoute(settings);
        }
      },
      initialRoute: isFirstLaunch ? AppRoutes.welcome : AppRoutes.home,
    );
  }
}
