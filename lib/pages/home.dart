import 'package:bloodpressurelog/components/ad_widget.dart';
import 'package:bloodpressurelog/components/bpm_circular_percentage_indicator.dart';
import 'package:bloodpressurelog/components/dia_circular_percentage_indicator.dart';
import 'package:bloodpressurelog/components/empty_list.dart';
import 'package:bloodpressurelog/components/filter_measurements.dart';
import 'package:bloodpressurelog/components/line_area_graph.dart';
import 'package:bloodpressurelog/components/oxygention_circular_percent_indicator.dart';
import 'package:bloodpressurelog/components/page_sample.dart' as components;
import 'package:bloodpressurelog/components/sys_circular_percentage_indicator.dart';
import 'package:bloodpressurelog/constants.dart';
import 'package:bloodpressurelog/domain/lang/app_localization.dart';
import 'package:bloodpressurelog/domain/providers/measurement_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  createBody() {
    return ListView(children: [
      ADWidget(banner: kbanner),
      const FilterMeasurements(),
      const SizedBox(height: 5),
      Consumer<MeasurementProvider>(builder: (context, measurementProvider, _) {
        if (measurementProvider.measurements == null ||
            measurementProvider.measurements!.isEmpty) {
          return EmptyListPlaceHolder(
              title:
                  AppLocalizations.of(context)!.translate("noValuesDetected")!,
              descrizione: AppLocalizations.of(context)!
                  .translate("noValuesDetectedDetail")!,
              image: const AssetImage("assets/images/bloodpressure.png"));
        }

        return Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
            child: Column(children: [
              Card(
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                const SizedBox(height: 5),
                Center(
                    child: Text(
                        AppLocalizations.of(context)!.translate("avgValues")!,
                        style: const TextStyle(fontWeight: FontWeight.bold))),
                const SizedBox(height: 10),
                SizedBox(
                    height: 100,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          SysCircularPercentageIndicator(
                              value: calculateAvgSys(
                                  measurementProvider.measurements!)),
                          const SizedBox(width: 20),
                          DiaCircularPercentageIndicator(
                              value: calculateAvgDia(
                                  measurementProvider.measurements!)),
                        ])),
                const SizedBox(height: 10),
                SizedBox(
                    height: 100,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          BpmCircularPercentageIndicator(
                              value: calculateAvgBpm(
                                  measurementProvider.measurements!)),
                          const SizedBox(width: 20),
                          OxygenationCircularPercentageIndicator(
                              value: calculateAvgSpo2(
                                  measurementProvider.measurements!))
                        ])),
                const SizedBox(height: 10),
              ])),
              const SizedBox(height: 10),
              Card(
                  child: Column(children: [
                const SizedBox(height: 10),
                Center(
                    child: Text(
                        AppLocalizations.of(context)!
                            .translate("graphVariation")!,
                        style: const TextStyle(fontWeight: FontWeight.bold))),
                LineAreaGraph(
                    measurements: measurementProvider.measurements!,
                    animate: true),
                const SizedBox(height: 5),
              ]))
            ]));
      })
    ]);
  }

  @override
  void initState() {
    super.initState();

    Provider.of<MeasurementProvider>(context, listen: false).readFilter();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return components.Page(
      name: "home",
      body: createBody(),
      showBottomBar: true,
      appBarActions: const [],
    );
  }
}
