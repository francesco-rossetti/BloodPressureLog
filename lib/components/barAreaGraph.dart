import 'package:bloodpressurelog/constants.dart';
import 'package:bloodpressurelog/utils/AppLocalization.dart';
import 'package:bloodpressurelog/utils/database/models/measurement.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class BarAreaGraph extends StatelessWidget {
  final List<Measurement> measurements;
  final bool animate;

  BarAreaGraph({this.measurements, this.animate});

  @override
  Widget build(BuildContext context) {
    var chart = charts.BarChart(
      _createData(measurements, context),
      animate: animate,
      defaultRenderer: new charts.BarRendererConfig(
          cornerStrategy: const charts.ConstCornerStrategy(30)),
    );

    return new Padding(
      padding: new EdgeInsets.all(2.0),
      child: new SizedBox(
        height: 250.0,
        child: chart,
      ),
    );
  }

  static List<charts.Series<Reports, String>> _createData(
      List<Measurement> measurements, BuildContext context) {
    final partialData = [
      new Reports('hypotension', 0, kHypotensionColor),
      new Reports('regular', 0, kRegularColor),
      new Reports('elevated', 0, kElevatedColor),
      new Reports('hypertensionstage1', 0, kHypertension1Color),
      new Reports('hypertensionstage2', 0, kHypertension2Color),
      new Reports('hypertensivecrisis', 0, kHypertensionCrisisColor),
    ];

    measurements.forEach((element) {
      switch (calculateLevel(element.sysMeasurement, element.diaMeasurement)) {
        case "hypotension":
          partialData[0].numberOfOccurences++;
          break;
        case "regular":
          partialData[1].numberOfOccurences++;
          break;
        case "elevated":
          partialData[2].numberOfOccurences++;
          break;
        case "hypertensionstage1":
          partialData[3].numberOfOccurences++;
          break;
        case "hypertensionstage2":
          partialData[4].numberOfOccurences++;
          break;
        case "hypertensivecrisis":
          partialData[5].numberOfOccurences++;
          break;
      }
    });

    List<Reports> data = new List<Reports>();

    partialData.forEach((element) {
      if (element.numberOfOccurences > 0) data.add(element);
    });

    return [
      new charts.Series<Reports, String>(
        id: 'Reports',
        colorFn: (Reports report, __) =>
            charts.ColorUtil.fromDartColor(report.color),
        domainFn: (Reports report, _) =>
            AppLocalizations.of(context).translate(report.category),
        measureFn: (Reports report, _) => report.numberOfOccurences,
        data: data,
      )
    ];
  }
}

class Reports {
  final String category;
  int numberOfOccurences;
  Color color;

  Reports(this.category, this.numberOfOccurences, this.color);
}
