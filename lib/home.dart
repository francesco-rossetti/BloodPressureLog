import 'package:bloodpressurelog/components/bpm_circular_percentage_indicator.dart';
import 'package:bloodpressurelog/components/dia_circular_percentage_indicator.dart';
import 'package:bloodpressurelog/components/empty_list.dart';
import 'package:bloodpressurelog/components/line_area_graph.dart';
import 'package:bloodpressurelog/components/oxygention_circular_percent_indicator.dart';
import 'package:bloodpressurelog/components/sys_circular_percentage_indicator.dart';
import 'package:bloodpressurelog/constants.dart';
import 'package:bloodpressurelog/utils/app_localization.dart';
import 'package:bloodpressurelog/utils/database/controllers/measurement_service.dart';
import 'package:bloodpressurelog/utils/database/models/measurement.dart';
import 'package:flutter/material.dart';
import 'package:bloodpressurelog/components/page_sample.dart' as components;

import 'constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int action = 0;

  generateBody(BuildContext context) {
    return FutureBuilder(
      future: MeasurementService().readFilter(action),
      builder: (context, AsyncSnapshot<List<Measurement>> snapshot) {
        if (!snapshot.hasData) return Container();
        if (snapshot.data!.isEmpty) {
          return ListView(children: [
            kbanner,
            Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                child: Card(
                    child: Column(children: [
                  const SizedBox(height: 10),
                  Text(AppLocalizations.of(context)!.translate("filter")!,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Expanded(
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                        TextButton(
                          child: Text(
                              AppLocalizations.of(context)!.translate("week")!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal)),
                          onPressed: () {
                            setState(() {
                              action = 0;
                            });
                          },
                        ),
                        TextButton(
                          child: Text(
                              AppLocalizations.of(context)!.translate("month")!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal)),
                          onPressed: () {
                            setState(() {
                              action = 1;
                            });
                          },
                        ),
                        TextButton(
                          child: Text(
                              AppLocalizations.of(context)!.translate("year")!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal)),
                          onPressed: () {
                            setState(() {
                              action = 2;
                            });
                          },
                        ),
                        TextButton(
                          child: Text(
                              AppLocalizations.of(context)!.translate("all")!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal)),
                          onPressed: () {
                            setState(() {
                              action = 3;
                            });
                          },
                        ),
                      ])),
                  const SizedBox(height: 5),
                ]))),
            const SizedBox(height: 5),
            EmptyListPlaceHolder(
                title: AppLocalizations.of(context)!
                    .translate("noValuesDetected")!,
                descrizione: AppLocalizations.of(context)!
                    .translate("noValuesDetectedDetail")!,
                image: const AssetImage("assets/images/bloodpressure.png"))
          ]);
        }

        return ListView(
          children: [
            kbanner,
            Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                child: Card(
                    child: Column(children: [
                  const SizedBox(height: 10),
                  Text(AppLocalizations.of(context)!.translate("filter")!,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Expanded(
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                        TextButton(
                          child: Text(
                              AppLocalizations.of(context)!.translate("week")!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal)),
                          onPressed: () {
                            setState(() {
                              action = 0;
                            });
                          },
                        ),
                        TextButton(
                          child: Text(
                              AppLocalizations.of(context)!.translate("month")!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal)),
                          onPressed: () {
                            setState(() {
                              action = 1;
                            });
                          },
                        ),
                        TextButton(
                          child: Text(
                              AppLocalizations.of(context)!.translate("year")!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal)),
                          onPressed: () {
                            setState(() {
                              action = 2;
                            });
                          },
                        ),
                        TextButton(
                          child: Text(
                              AppLocalizations.of(context)!.translate("all")!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal)),
                          onPressed: () {
                            setState(() {
                              action = 3;
                            });
                          },
                        ),
                      ])),
                  const SizedBox(height: 5),
                ]))),
            Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                child: Card(
                    child: Column(mainAxisSize: MainAxisSize.min, children: <
                        Widget>[
                  const SizedBox(height: 5),
                  Center(
                      child: Text(
                          AppLocalizations.of(context)!.translate("avgValues")!,
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                  const SizedBox(height: 10),
                  Expanded(
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                        SysCircularPercentageIndicator(
                            value: calculateAvgSys(snapshot.data!)),
                        const SizedBox(width: 20),
                        DiaCircularPercentageIndicator(
                            value: calculateAvgDia(snapshot.data!)),
                      ])),
                  const SizedBox(height: 10),
                  Expanded(
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                        BpmCircularPercentageIndicator(
                            value: calculateAvgBpm(snapshot.data!)),
                        const SizedBox(width: 20),
                        OxygenationCircularPercentageIndicator(
                            value: calculateAvgSpo2(snapshot.data!))
                      ])),
                  const SizedBox(height: 10),
                ]))),
            Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                child: Card(
                    child: Column(mainAxisSize: MainAxisSize.min, children: <
                        Widget>[
                  const SizedBox(height: 5),
                  Center(
                      child: Text(
                          AppLocalizations.of(context)!
                              .translate("graphVariation")!,
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                  LineAreaGraph(measurements: snapshot.data!, animate: true),
                  const SizedBox(height: 5),
                ]))),
            const SizedBox(height: 30),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return components.Page(
        name: "appName", showBottomBar: true, body: generateBody(context));
  }
}
