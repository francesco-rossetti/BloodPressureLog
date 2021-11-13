import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:bloodpressurelog/components/on_boarding.dart';
import 'package:bloodpressurelog/components/quick_actions_manager.dart';
import 'package:bloodpressurelog/home.dart';
import 'package:bloodpressurelog/utils/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget home = const IntroScreen(isReplay: false);

Future checkFirstSeen() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool _seen = (prefs.getBool('BloodPressureLog') ?? false);

  if (_seen) {
    home = const HomePage();
  } else {
    await prefs.setBool('BloodPressureLog', true);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await checkFirstSeen();

  Admob.initialize();

  if (Platform.isIOS) await Admob.requestTrackingAuthorization();

  runApp(const MyApp());
}

Locale localeCallback(locale, supportedLocales) {
  for (var supportedLocale in supportedLocales) {
    if (supportedLocale.languageCode == locale.languageCode &&
        supportedLocale.countryCode == locale.countryCode) {
      return supportedLocale;
    }
  }

  return supportedLocales.first;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Pressure Diary',
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: "Rubik",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: "Rubik",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      supportedLocales: const [Locale('en', 'US'), Locale('it', 'IT')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: localeCallback,
      home: QuickActionsManager(child: home),
    );
  }
}
