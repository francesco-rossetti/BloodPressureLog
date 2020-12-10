import 'package:bloodpressurelog/components/bpmCircularPercentIndicator.dart';
import 'package:bloodpressurelog/components/diaCircularPercentIndicator.dart';
import 'package:bloodpressurelog/components/emptyList.dart';
import 'package:bloodpressurelog/components/lineAreaGraph.dart';
import 'package:bloodpressurelog/components/oxygentionCircularPercentIndicator.dart';
import 'package:bloodpressurelog/components/sysCircularPercentIndicator.dart';
import 'package:bloodpressurelog/constants.dart';
import 'package:bloodpressurelog/utils/AppLocalization.dart';
import 'package:bloodpressurelog/utils/database/controllers/measurementService.dart';
import 'package:bloodpressurelog/utils/database/models/measurement.dart';
import 'package:flutter/material.dart';
import 'package:bloodpressurelog/components/pageSample.dart' as components;

import 'constants.dart';

class HomePage extends StatefulWidget {
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
        if (snapshot.data.isEmpty)
          return ListView(children: [
            kbanner,
            Padding(
                padding: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                child: Card(
                    child: Column(children: [
                  SizedBox(height: 10),
                  Text(AppLocalizations.of(context).translate("filter"),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Container(
                      height: 50,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            FlatButton(
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate("week"),
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal)),
                              onPressed: () {
                                setState(() {
                                  action = 0;
                                });
                              },
                            ),
                            FlatButton(
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate("month"),
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal)),
                              onPressed: () {
                                setState(() {
                                  action = 1;
                                });
                              },
                            ),
                            FlatButton(
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate("year"),
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal)),
                              onPressed: () {
                                setState(() {
                                  action = 2;
                                });
                              },
                            ),
                            FlatButton(
                              child: Text(
                                  AppLocalizations.of(context).translate("all"),
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal)),
                              onPressed: () {
                                setState(() {
                                  action = 3;
                                });
                              },
                            ),
                          ])),
                  SizedBox(height: 5),
                ]))),
            SizedBox(height: 5),
            EmptyListPlaceHolder(
                title:
                    AppLocalizations.of(context).translate("noValuesDetected"),
                descrizione: AppLocalizations.of(context)
                    .translate("noValuesDetectedDetail"),
                image: AssetImage("assets/images/bloodpressure.png"))
          ]);

        return ListView(
          children: [
            kbanner,
            Padding(
                padding: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                child: Card(
                    child: Column(children: [
                  SizedBox(height: 10),
                  Text(AppLocalizations.of(context).translate("filter"),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Container(
                      height: 50,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            FlatButton(
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate("week"),
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal)),
                              onPressed: () {
                                setState(() {
                                  action = 0;
                                });
                              },
                            ),
                            FlatButton(
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate("month"),
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal)),
                              onPressed: () {
                                setState(() {
                                  action = 1;
                                });
                              },
                            ),
                            FlatButton(
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate("year"),
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal)),
                              onPressed: () {
                                setState(() {
                                  action = 2;
                                });
                              },
                            ),
                            FlatButton(
                              child: Text(
                                  AppLocalizations.of(context).translate("all"),
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal)),
                              onPressed: () {
                                setState(() {
                                  action = 3;
                                });
                              },
                            ),
                          ])),
                  SizedBox(height: 5),
                ]))),
            Padding(
                padding: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                child: Card(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                      SizedBox(height: 5),
                      Center(
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate("avgValues"),
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(height: 10),
                      Container(
                          height: 100,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children: [
                                SysCircularPercentIndicator(
                                    calculateAvgSys(snapshot.data)),
                                SizedBox(width: 20),
                                DiaCircularPercentIndicator(
                                    calculateAvgDia(snapshot.data)),
                              ])),
                      SizedBox(height: 10),
                      Container(
                          height: 100,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children: [
                                BpmCircularPercentIndicator(
                                    calculateAvgBpm(snapshot.data)),
                                SizedBox(width: 20),
                                OxygenationCircularPercentIndicator(
                                    calculateAvgSpo2(snapshot.data))
                              ])),
                      SizedBox(height: 10),
                    ]))),
            Padding(
                padding: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                child: Card(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                      SizedBox(height: 5),
                      Center(
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate("graphVariation"),
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      LineAreaGraph(measurements: snapshot.data),
                      SizedBox(height: 5),
                    ]))),
            SizedBox(height: 30),
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
