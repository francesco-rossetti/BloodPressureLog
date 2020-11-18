import 'package:admob_flutter/admob_flutter.dart';
import 'package:bloodpressurelog/utils/database/models/measurement.dart';
import 'package:flutter/material.dart';

const String kBannerID = "ca-app-pub-3318650813130043/5546963278";
const String kInterstitialID = "ca-app-pub-3318650813130043/4533264503";

AdmobBanner kbanner =
    AdmobBanner(adUnitId: kBannerID, adSize: AdmobBannerSize.BANNER);

const kBackgroundColor = Color(0xFFF1EFF1);
const kPrimaryColor = Color(0xFF1976D2);
const kSecondaryColor = Color(0xFFFF9800);
const kTabBarColor = Color(0xFFD6D6D6);
const kDisactiveTabColor = Color(0xFF686868);
const kTextColor = Color(0xFF212121);
const kTextLightColor = Color(0xFF757575);
const kBlueColor = Color(0xFF40BAD5);
const kOrangeColor = Color(0xFFFFC206);

const kHypotensionColor = Color(0xff03a9f4);
const kRegularColor = Color(0xff4caf50);
const kElevatedColor = Color(0xffffc107);
const kHypertension1Color = Color(0xffff9800);
const kHypertension2Color = Color(0xffe64a19);
const kHypertensionCrisisColor = Color(0xffbf360c);

const kDefaultPadding = 20.0;
const kDefaultRound = 40.0;

const kDefaultShadow = BoxShadow(
  offset: Offset(0, 15),
  blurRadius: 27,
  color: Colors.black12,
);

String calculateLevel(int sysRecord, int diaRecord) {
  if (sysRecord < 90 && diaRecord < 60) {
    return "hypotension";
  } else if ((sysRecord >= 90 && sysRecord < 120) &&
      (diaRecord >= 60 && diaRecord < 80)) {
    return "regular";
  } else if ((sysRecord >= 120 && sysRecord <= 130) && (diaRecord < 80)) {
    return "elevated";
  } else if ((sysRecord > 130 && sysRecord <= 140) &&
      (diaRecord >= 80 && diaRecord <= 90)) {
    return "hypertensionstage1";
  } else if ((sysRecord > 140 && sysRecord <= 180) &&
      (diaRecord > 90 && diaRecord <= 120)) {
    return "hypertensionstage2";
  } else if ((sysRecord > 180) && diaRecord > 120) {
    return "hypertensivecrisis";
  }

  return "";
}

int calculateAvgSys(List<Measurement> measurements) {
  double avg = 0;

  measurements.forEach((element) {
    avg += element.sysMeasurement;
  });

  avg /= measurements.length;

  return avg.round();
}

int calculateAvgDia(List<Measurement> measurements) {
  double avg = 0;

  measurements.forEach((element) {
    avg += element.diaMeasurement;
  });

  avg /= measurements.length;

  return avg.round();
}

int calculateAvgBpm(List<Measurement> measurements) {
  double avg = 0;

  measurements.forEach((element) {
    avg += element.bpmMeasurement;
  });

  avg /= measurements.length;

  return avg.round();
}
