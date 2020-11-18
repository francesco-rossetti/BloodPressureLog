import 'package:bloodpressurelog/constants.dart';
import 'package:bloodpressurelog/updateRecord.dart';
import 'package:bloodpressurelog/utils/AppLocalization.dart';
import 'package:bloodpressurelog/utils/PDFProvider.dart';
import 'package:bloodpressurelog/utils/database/controllers/measurementService.dart';
import 'package:bloodpressurelog/utils/database/models/measurement.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:bloodpressurelog/components/pageSample.dart' as components;
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int action = 0;

  createBody(BuildContext context) {
    return Column(children: [
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
                            AppLocalizations.of(context).translate("week"),
                            style: TextStyle(fontWeight: FontWeight.normal)),
                        textColor: Colors.black,
                        onPressed: () {
                          setState(() {
                            action = 0;
                          });
                        },
                      ),
                      FlatButton(
                        child: Text(
                            AppLocalizations.of(context).translate("month"),
                            style: TextStyle(fontWeight: FontWeight.normal)),
                        textColor: Colors.black,
                        onPressed: () {
                          setState(() {
                            action = 1;
                          });
                        },
                      ),
                      FlatButton(
                        child: Text(
                            AppLocalizations.of(context).translate("year"),
                            style: TextStyle(fontWeight: FontWeight.normal)),
                        textColor: Colors.black,
                        onPressed: () {
                          setState(() {
                            action = 2;
                          });
                        },
                      ),
                      FlatButton(
                        child: Text(
                            AppLocalizations.of(context).translate("all"),
                            style: TextStyle(fontWeight: FontWeight.normal)),
                        textColor: Colors.black,
                        onPressed: () {
                          setState(() {
                            action = 3;
                          });
                        },
                      ),
                    ])),
            SizedBox(height: 5),
          ]))),
      Expanded(
          child: FutureBuilder(
              future: MeasurementService().readFilter(action),
              builder: (context, AsyncSnapshot<List<Measurement>> snapshot) {
                if (!snapshot.hasData) return Container();

                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var level = calculateLevel(
                          snapshot.data[index].sysMeasurement,
                          snapshot.data[index].diaMeasurement);

                      Color color = Colors.white;

                      switch (level) {
                        case "hypotension":
                          color = kHypotensionColor;
                          break;

                        case "regular":
                          color = kRegularColor;
                          break;

                        case "elevated":
                          color = kElevatedColor;
                          break;

                        case "hypertensionstage1":
                          color = kHypertension1Color;
                          break;

                        case "hypertensionstage2":
                          color = kHypertension2Color;
                          break;

                        case "hypertensivecrisis":
                          color = kHypertensionCrisisColor;
                          break;
                      }

                      return GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        UpdateRecord(
                                            measurement: snapshot.data[index])))
                                .then((value) {
                              setState(() {});
                            });
                          },
                          child: Card(
                              child: ListTile(
                            leading: Container(
                              width: 60,
                              height: 60,
                              child: Center(
                                  child: Text(
                                      snapshot.data[index].sysMeasurement
                                              .toString() +
                                          "\n" +
                                          snapshot.data[index].diaMeasurement
                                              .toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white))),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: color),
                            ),
                            title: Text(
                                AppLocalizations.of(context).translate(level),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(DateFormat("yyyy-MM-dd HH:mm:ss")
                                    .format(snapshot
                                        .data[index].dateTimeMeasurement) +
                                " | " +
                                snapshot.data[index].bpmMeasurement.toString() +
                                "bpm"),
                          )));
                    });
              }))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return components.Page(
        name: "historyValues",
        showBottomBar: true,
        body: createBody(context),
        appBarActions: [
          IconButton(
            icon: Icon(Icons.share, color: Colors.white),
            onPressed: () async {
              var path = await PDFProvider.pdfAziendePeriod(context, action);
              Share.shareFiles([path],
                  subject: AppLocalizations.of(context)
                      .translate("exportMeasurements"));
            },
          )
        ]);
  }
}
