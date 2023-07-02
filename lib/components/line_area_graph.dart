import 'package:bloodpressurelog/domain/database/models/measurement.dart';
import 'package:bloodpressurelog/domain/lang/app_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineAreaGraph extends StatefulWidget {
  const LineAreaGraph(
      {Key? key, required this.measurements, required this.animate})
      : super(key: key);

  final List<Measurement> measurements;
  final bool animate;

  @override
  State<LineAreaGraph> createState() => _LineAreaGraphState();
}

class _LineAreaGraphState extends State<LineAreaGraph> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: widget.measurements
                  .map((point) => FlSpot(point.idMeasurement!.toDouble(),
                      point.sysMeasurement!.toDouble()))
                  .toList(),
              isCurved: true,
            ),
            LineChartBarData(
              spots: widget.measurements
                  .map((point) => FlSpot(point.idMeasurement!.toDouble(),
                      point.diaMeasurement!.toDouble()))
                  .toList(),
              isCurved: true,
            ),
            LineChartBarData(
              spots: widget.measurements
                  .map((point) => FlSpot(point.idMeasurement!.toDouble(),
                      point.bpmMeasurement!.toDouble()))
                  .toList(),
              isCurved: true,
            ),
          ],
        ),
      ),
    );
  }
}
/*
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
*/