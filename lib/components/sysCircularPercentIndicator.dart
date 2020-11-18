import 'package:bloodpressurelog/utils/AppLocalization.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SysCircularPercentIndicator extends StatelessWidget {
  final int value;

  SysCircularPercentIndicator(this.value);

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
              Text(AppLocalizations.of(context).translate("lblSYS")),
              SizedBox(height: 3),
              Text(value.toString(), style: TextStyle(fontSize: 25)),
              SizedBox(height: 5),
              Text("mmHg", style: TextStyle(fontStyle: FontStyle.italic)),
            ]));
  }
}
