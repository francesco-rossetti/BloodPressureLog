import 'package:bloodpressurelog/utils/AppLocalization.dart';
import 'package:bloodpressurelog/utils/database/models/measurement.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class LineAreaGraph extends StatelessWidget {
  final List<Measurement> measurements;
  final bool animate;

  LineAreaGraph({this.measurements, this.animate});

  @override
  Widget build(BuildContext context) {
    var chart = new charts.LineChart(_createData(this.measurements, context),
        defaultRenderer: new charts.LineRendererConfig(includeArea: true),
        behaviors: [new charts.SeriesLegend(horizontalFirst: false)],
        animate: animate);

    return new Padding(
      padding: new EdgeInsets.all(2.0),
      child: new SizedBox(
        height: 500.0,
        child: chart,
      ),
    );
  }

  static List<charts.Series<Measurement, int>> _createData(
      List<Measurement> measurements, BuildContext context) {
    return [
      new charts.Series<Measurement, int>(
        id: AppLocalizations.of(context).translate("sys"),
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Measurement measurement, _) =>
            measurements.indexOf(measurement),
        measureFn: (Measurement measurement, _) => measurement.sysMeasurement,
        data: measurements,
      ),
      new charts.Series<Measurement, int>(
        id: AppLocalizations.of(context).translate("dia"),
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (Measurement measurement, _) =>
            measurements.indexOf(measurement),
        measureFn: (Measurement measurement, _) => measurement.diaMeasurement,
        data: measurements,
      ),
      new charts.Series<Measurement, int>(
        id: AppLocalizations.of(context).translate("bpm"),
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (Measurement measurement, _) =>
            measurements.indexOf(measurement),
        measureFn: (Measurement measurement, _) => measurement.bpmMeasurement,
        data: measurements,
      ),
      new charts.Series<Measurement, int>(
        id: AppLocalizations.of(context).translate("oxygenationLevel"),
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
        domainFn: (Measurement measurement, _) =>
            measurements.indexOf(measurement),
        measureFn: (Measurement measurement, _) =>
            measurement.oxygenationMesurement,
        data: measurements,
      ),
    ];
  }
}
