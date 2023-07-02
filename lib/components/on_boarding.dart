import 'package:bloodpressurelog/constants.dart';
import 'package:bloodpressurelog/domain/lang/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:bloodpressurelog/pages/home.dart';

class IntroScreen extends StatefulWidget {
  final bool isReplay;

  const IntroScreen({Key? key, required this.isReplay}) : super(key: key);

  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<ContentConfig> slides = [];

  @override
  void initState() {
    super.initState();
  }

  void onDonePress() {
    if (widget.isReplay) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    slides.add(
      ContentConfig(
        title: AppLocalizations.of(context)!.translate("appName")!,
        description:
            AppLocalizations.of(context)!.translate("onBoarding1Detail"),
        pathImage: "assets/images/icon.png",
        backgroundColor: kOnBoarding1Color,
      ),
    );
    slides.add(
      ContentConfig(
        title: AppLocalizations.of(context)!.translate("appName"),
        description:
            AppLocalizations.of(context)!.translate("onBoarding2Detail"),
        pathImage: "assets/images/onboard1.png",
        backgroundColor: kOnBoarding2Color,
      ),
    );
    slides.add(
      ContentConfig(
        title: AppLocalizations.of(context)!.translate("appName"),
        description:
            AppLocalizations.of(context)!.translate("onBoarding3Detail"),
        pathImage: "assets/images/bloodpressure.png",
        backgroundColor: kOnBoarding3Color,
      ),
    );

    return IntroSlider(
      listContentConfig: slides,
      skipButtonStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white)),
      nextButtonStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white)),
      doneButtonStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white)),
      prevButtonStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white)),
      onDonePress: onDonePress,
      onSkipPress: onDonePress,
    );
  }
}
