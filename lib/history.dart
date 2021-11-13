import 'package:bloodpressurelog/constants.dart';
import 'package:bloodpressurelog/update_record.dart';
import 'package:bloodpressurelog/utils/app_localization.dart';
import 'package:bloodpressurelog/utils/pdf_provider.dart';
import 'package:bloodpressurelog/utils/database/controllers/measurement_service.dart';
import 'package:bloodpressurelog/utils/database/models/measurement.dart';
import 'package:flutter/material.dart';
import 'package:bloodpressurelog/components/page_sample.dart' as components;
import 'package:share_plus/share_plus.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int action = 0;

  createBody(BuildContext context) {
    return Column(children: [
      kbanner,
      Card(
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
                child: Text(AppLocalizations.of(context)!.translate("week")!,
                    style: const TextStyle(fontWeight: FontWeight.normal)),
                onPressed: () {
                  setState(() {
                    action = 0;
                  });
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.translate("month")!,
                    style: const TextStyle(fontWeight: FontWeight.normal)),
                onPressed: () {
                  setState(() {
                    action = 1;
                  });
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.translate("year")!,
                    style: const TextStyle(fontWeight: FontWeight.normal)),
                onPressed: () {
                  setState(() {
                    action = 2;
                  });
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.translate("all")!,
                    style: const TextStyle(fontWeight: FontWeight.normal)),
                onPressed: () {
                  setState(() {
                    action = 3;
                  });
                },
              ),
            ])),
        const SizedBox(height: 5),
      ])),
      Expanded(
          child: FutureBuilder(
              future: MeasurementService().readFilter(action),
              builder: (context, AsyncSnapshot<List<Measurement>> snapshot) {
                if (!snapshot.hasData) return Container();

                return ListView.builder(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var level = calculateLevel(
                          snapshot.data![index].sysMeasurement!,
                          snapshot.data![index].diaMeasurement!);

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
                                            measurement:
                                                snapshot.data![index])))
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
                                      snapshot.data![index].sysMeasurement
                                              .toString() +
                                          "\n" +
                                          snapshot.data![index].diaMeasurement
                                              .toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white))),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: color),
                            ),
                            title: Text(
                                AppLocalizations.of(context)!.translate(level)!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            subtitle: snapshot
                                        .data![index].oxygenationMesurement !=
                                    null
                                ? Text(langFormatDate(
                                        context,
                                        snapshot.data![index]
                                            .dateTimeMeasurement!) +
                                    " | " +
                                    snapshot.data![index].bpmMeasurement
                                        .toString() +
                                    "bpm" +
                                    " | " +
                                    snapshot.data![index].oxygenationMesurement
                                        .toString() +
                                    "%")
                                : Text(langFormatDate(
                                        context,
                                        snapshot.data![index]
                                            .dateTimeMeasurement!) +
                                    " | " +
                                    snapshot.data![index].bpmMeasurement!
                                        .toString() +
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
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () async {
              var path =
                  await PDFProvider.pdfMeasurementPeriod(context, action);
              Share.shareFiles([path!],
                  subject: AppLocalizations.of(context)!
                      .translate("exportMeasurements"));
            },
          )
        ]);
  }
}
