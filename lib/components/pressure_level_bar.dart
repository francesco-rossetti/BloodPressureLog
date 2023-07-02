import 'package:bloodpressurelog/constants.dart';
import 'package:bloodpressurelog/domain/lang/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PressureLevelBar extends StatefulWidget {
  final int sysRecord, diaRecord;

  const PressureLevelBar(
      {Key? key, required this.sysRecord, required this.diaRecord})
      : super(key: key);

  @override
  PressureLevelBarState createState() => PressureLevelBarState();
}

class PressureLevelBarState extends State<PressureLevelBar> {
  static String statusLabel = "regular";
  static int selectedIndex = 1;

  void calculatePressureLevel() {
    statusLabel = calculateLevel(widget.sysRecord, widget.diaRecord);

    switch (statusLabel) {
      case "low":
        selectedIndex = 1;
        break;

      case "regular":
        selectedIndex = 2;
        break;

      case "elevated":
        selectedIndex = 3;
        break;

      case "hypertensionstage1":
        selectedIndex = 4;
        break;

      case "hypertensionstage2":
        selectedIndex = 5;
        break;

      case "hypertensivecrisis":
        selectedIndex = 6;
        break;

      default:
        selectedIndex = 0;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    calculatePressureLevel();
    return Column(children: [
      Center(
          child: Text(AppLocalizations.of(context)!.translate(statusLabel)!,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
      const SizedBox(height: 5),
      StepProgressIndicator(
          totalSteps: 7,
          padding: 0,
          size: 40,
          currentStep: 3,
          selectedColor: Colors.transparent,
          customStep: (index, color, __) {
            if (index == selectedIndex) {
              return Container(
                  color: color,
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ));
            }

            return Container(color: color);
          },
          customColor: (index) {
            switch (index) {
              case 1:
                return kLowColor;
              case 2:
                return kRegularColor;
              case 3:
                return kElevatedColor;
              case 4:
                return kHypertension1Color;
              case 5:
                return kHypertension2Color;
              case 6:
                return kHypertensionCrisisColor;
              default:
                return kNDColor;
            }
          })
    ]);
  }
}
