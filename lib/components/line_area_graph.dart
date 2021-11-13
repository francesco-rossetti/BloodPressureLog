import 'package:bloodpressurelog/utils/app_localization.dart';
import 'package:bloodpressurelog/utils/database/models/measurement.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class LineAreaGraph extends StatelessWidget {
  final List<Measurement> measurements;
  final bool animate;

  const LineAreaGraph(
      {Key? key, required this.measurements, required this.animate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var chart = charts.LineChart(_createData(measurements, context),
        defaultRenderer: charts.LineRendererConfig(includeArea: true),
        behaviors: [charts.SeriesLegend(horizontalFirst: false)],
        animate: animate);

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
        height: 500.0,
        child: chart,
      ),
    );
  }

  static List<charts.Series<Measurement, int>> _createData(
      List<Measurement> measurements, BuildContext context) {
    return [
      charts.Series<Measurement, int>(
        id: AppLocalizations.of(context)!.translate("sys")!,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Measurement measurement, _) =>
            measurements.indexOf(measurement),
        measureFn: (Measurement measurement, _) => measurement.sysMeasurement,
        data: measurements,
      ),
      charts.Series<Measurement, int>(
        id: AppLocalizations.of(context)!.translate("dia")!,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (Measurement measurement, _) =>
            measurements.indexOf(measurement),
        measureFn: (Measurement measurement, _) => measurement.diaMeasurement,
        data: measurements,
      ),
      charts.Series<Measurement, int>(
        id: AppLocalizations.of(context)!.translate("bpm")!,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (Measurement measurement, _) =>
            measurements.indexOf(measurement),
        measureFn: (Measurement measurement, _) => measurement.bpmMeasurement,
        data: measurements,
      ),
      charts.Series<Measurement, int>(
        id: AppLocalizations.of(context)!.translate("oxygenationLevel")!,
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
