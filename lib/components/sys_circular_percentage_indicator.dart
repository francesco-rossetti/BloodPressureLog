import 'package:bloodpressurelog/domain/lang/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SysCircularPercentageIndicator extends StatelessWidget {
  final int value;

  const SysCircularPercentageIndicator({Key? key, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var v = ((value / 200) * 100).round();

    return CircularStepProgressIndicator(
        totalSteps: 100,
        currentStep: v,
        width: 100,
        roundedCap: (_, __) => true,
        selectedColor: Colors.blueAccent,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.translate("lblSYS")!),
              const SizedBox(height: 3),
              Text(value.toString(), style: const TextStyle(fontSize: 25)),
              const SizedBox(height: 5),
              const Text("mmHg", style: TextStyle(fontStyle: FontStyle.italic)),
            ]));
  }
}
