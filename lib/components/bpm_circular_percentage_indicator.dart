import 'package:bloodpressurelog/utils/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class BpmCircularPercentageIndicator extends StatelessWidget {
  final int value;

  const BpmCircularPercentageIndicator({Key? key, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var v = ((value / 200) * 10).round();

    return CircularStepProgressIndicator(
        totalSteps: 10,
        currentStep: v,
        width: 100,
        roundedCap: (_, isSelected) => isSelected,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.translate("lblBPM")!),
              const SizedBox(height: 3),
              Text(value.toString(), style: const TextStyle(fontSize: 25)),
              const SizedBox(height: 5),
              const Text("bpm", style: TextStyle(fontStyle: FontStyle.italic)),
            ]));
  }
}
