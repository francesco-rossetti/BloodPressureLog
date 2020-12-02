import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:bloodpressurelog/components/onBoarding.dart';
import 'package:bloodpressurelog/home.dart';
import 'package:bloodpressurelog/utils/AppLocalization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget home = IntroScreen(isReplay: false);

Future checkFirstSeen() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool _seen = (prefs.getBool('BloodPressureLog') ?? false);

  if (_seen) {
    home = HomePage();
  } else {
    await prefs.setBool('BloodPressureLog', true);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await checkFirstSeen();

  Firebase.initializeApp();
  Admob.initialize();

  if (Platform.isIOS) await Admob.requestTrackingAuthorization();

  runApp(MyApp());
}

Locale localeCallback(locale, supportedLocales) {
  for (var supportedLocale in supportedLocales) {
    if (supportedLocale.languageCode == locale.languageCode &&
        supportedLocale.countryCode == locale.countryCode)
      return supportedLocale;
  }

  return supportedLocales.first;
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

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
      supportedLocales: [Locale('en', 'US'), Locale('it', 'IT')],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: localeCallback,
      navigatorObservers: <NavigatorObserver>[observer],
      home: home,
    );
  }
}
