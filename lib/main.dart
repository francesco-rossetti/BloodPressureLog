import 'package:bloodpressurelog/components/on_boarding.dart';
import 'package:bloodpressurelog/components/quick_actions_manager.dart';
import 'package:bloodpressurelog/domain/lang/app_localization.dart';
import 'package:bloodpressurelog/domain/providers/measurement_provider.dart';
import 'package:bloodpressurelog/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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
  MobileAds.instance.initialize();

  await checkFirstSeen();

  runApp(MyApp());
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
  final List<ChangeNotifierProvider> providers = [
    ChangeNotifierProvider<MeasurementProvider>(
        create: (BuildContext context) => MeasurementProvider())
  ];

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: providers,
        child: MaterialApp(
          title: 'Blood Pressure Diary',
          theme: ThemeData(
            brightness: Brightness.light,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: GoogleFonts.rubik().fontFamily,
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
        ));
  }
}
