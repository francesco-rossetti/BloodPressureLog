import 'package:bloodpressurelog/domain/database/models/measurement.dart';
import 'package:bloodpressurelog/domain/lang/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const String kBannerID = "ca-app-pub-3318650813130043/5546963278";
const String kInterstitialID = "ca-app-pub-3318650813130043/4533264503";
const String kDevURL =
    "https://play.google.com/store/apps/dev?id=6543884814941375849";
const String kSourcesURL =
    "https://www.forbes.com/health/healthy-aging/normal-blood-pressure-by-age-chart/";

/* AdmobBanner kbanner =
    AdmobBanner(adUnitId: kBannerID, adSize: AdmobBannerSize.BANNER);

AdmobBanner kLargeBanner =
    AdmobBanner(adUnitId: kBannerID, adSize: AdmobBannerSize.MEDIUM_RECTANGLE); */

const kPrimaryColor = Color(0xFF1976D2);
const kSecondaryColor = Color(0xFFFF9800);
const kOnBoarding1Color = Color(0xfff44336);
const kOnBoarding2Color = Color(0xff4caf50);
const kOnBoarding3Color = Color(0xff2196f3);

const kNDColor = Color(0xffffffff);
const kLowColor = Color(0xff03a9f4);
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
  if (sysRecord < 90) {
    return "low";
  } else if ((sysRecord >= 90 && sysRecord < 120) && (diaRecord < 80)) {
    return "regular";
  } else if ((sysRecord >= 120 && sysRecord < 130) && (diaRecord < 80)) {
    return "elevated";
  } else if ((sysRecord >= 130 && sysRecord < 140) &&
      (diaRecord >= 80 && diaRecord < 90)) {
    return "hypertensionstage1";
  } else if ((sysRecord >= 140 && sysRecord < 180) &&
      (diaRecord >= 90 && diaRecord < 120)) {
    return "hypertensionstage2";
  } else if ((sysRecord >= 180) && diaRecord >= 120) {
    return "hypertensivecrisis";
  }

  return "nd";
}

int calculateAvgSys(List<Measurement> measurements) {
  double avg = 0;

  for (var element in measurements) {
    avg += element.sysMeasurement!;
  }

  avg /= measurements.length;

  return avg.round();
}

int calculateAvgDia(List<Measurement> measurements) {
  double avg = 0;

  for (var element in measurements) {
    avg += element.diaMeasurement!;
  }

  avg /= measurements.length;

  return avg.round();
}

int calculateAvgBpm(List<Measurement> measurements) {
  double avg = 0;

  for (var element in measurements) {
    avg += element.bpmMeasurement!;
  }

  avg /= measurements.length;

  return avg.round();
}

int calculateAvgSpo2(List<Measurement> measurements) {
  double avg = 0;
  int count = 0;

  for (var element in measurements) {
    if (element.oxygenationMesurement != null) {
      avg += element.oxygenationMesurement!;
      count++;
    }
  }

  if (count != 0) avg /= count;

  return avg.round();
}

String langFormatDate(BuildContext context, DateTime date) {
  return AppLocalizations.of(context)!.locale.languageCode == "it"
      ? DateFormat("dd/MM/yyyy HH:mm:ss").format(date)
      : DateFormat("yyyy-MM-dd HH:mm:ss").format(date);
}

String langFormatDateOnly(BuildContext context, DateTime date) {
  return AppLocalizations.of(context)!.locale.languageCode == "it"
      ? DateFormat("dd/MM/yyyy").format(date)
      : DateFormat("yyyy-MM-dd").format(date);
}
