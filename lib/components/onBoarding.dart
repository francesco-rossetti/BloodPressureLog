import 'package:bloodpressurelog/constants.dart';
import 'package:bloodpressurelog/utils/AppLocalization.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:bloodpressurelog/home.dart';

class IntroScreen extends StatefulWidget {
  final bool isReplay;

  IntroScreen({Key key, @required this.isReplay}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();
  }

  void onDonePress() {
    if (widget.isReplay)
      Navigator.of(context).pop();
    else
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    slides.add(
      new Slide(
        title: AppLocalizations.of(context).translate("appName"),
        description:
            AppLocalizations.of(context).translate("onBoarding1Detail"),
        pathImage: "assets/images/onboard1.png",
        backgroundColor: kOnBoarding1Color,
      ),
    );
    slides.add(
      new Slide(
        title: AppLocalizations.of(context).translate("onBoarding2"),
        description:
            AppLocalizations.of(context).translate("onBoarding2Detail"),
        pathImage: "assets/images/onboard2.png",
        backgroundColor: kOnBoarding2Color,
      ),
    );
    slides.add(
      new Slide(
        title: AppLocalizations.of(context).translate("onBoarding3"),
        description:
            AppLocalizations.of(context).translate("onBoarding3Detail"),
        pathImage: "assets/images/bloodpressure.png",
        backgroundColor: kOnBoarding3Color,
      ),
    );

    return new IntroSlider(
      slides: slides,
      onDonePress: onDonePress,
      onSkipPress: onDonePress,
    );
  }
}
