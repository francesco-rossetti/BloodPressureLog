import 'package:bloodpressurelog/components/empty_list.dart';
import 'package:bloodpressurelog/components/filter_measurements.dart';
import 'package:bloodpressurelog/components/page_sample.dart' as components;
import 'package:bloodpressurelog/constants.dart';
import 'package:bloodpressurelog/domain/export/pdf_provider.dart';
import 'package:bloodpressurelog/domain/lang/app_localization.dart';
import 'package:bloodpressurelog/domain/providers/measurement_provider.dart';
import 'package:bloodpressurelog/pages/update_record.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  createBody() {
    return Column(children: [
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

        return Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                itemCount: measurementProvider.measurements!.length,
                itemBuilder: (context, index) {
                  var level = calculateLevel(
                      measurementProvider.measurements![index].sysMeasurement!,
                      measurementProvider.measurements![index].diaMeasurement!);

                  Color color = Colors.white;

                  switch (level) {
                    case "low":
                      color = kLowColor;
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

                    default:
                      color = kNDColor;
                      break;
                  }

                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    UpdateRecordPage(
                                        measurement: measurementProvider
                                            .measurements![index])))
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
                                  measurementProvider
                                          .measurements![index].sysMeasurement
                                          .toString() +
                                      "\n" +
                                      measurementProvider
                                          .measurements![index].diaMeasurement
                                          .toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white))),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: color),
                        ),
                        title: Text(
                            AppLocalizations.of(context)!.translate(level)!,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: measurementProvider.measurements![index]
                                    .oxygenationMesurement !=
                                null
                            ? Text(langFormatDate(
                                    context,
                                    measurementProvider.measurements![index]
                                        .dateTimeMeasurement!) +
                                " | " +
                                measurementProvider
                                    .measurements![index].bpmMeasurement
                                    .toString() +
                                "bpm" +
                                " | " +
                                measurementProvider
                                    .measurements![index].oxygenationMesurement
                                    .toString() +
                                "%")
                            : Text(langFormatDate(
                                    context,
                                    measurementProvider.measurements![index]
                                        .dateTimeMeasurement!) +
                                " | " +
                                measurementProvider
                                    .measurements![index].bpmMeasurement
                                    .toString() +
                                "bpm"),
                      )));
                }));
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
        name: "history",
        body: createBody(),
        showBottomBar: true,
        appBarActions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () async {
              int action =
                  Provider.of<MeasurementProvider>(context, listen: false)
                      .filterLevel;

              String? path =
                  await PDFProvider.pdfMeasurementPeriod(context, action);
              Share.shareFiles([path!],
                  subject: AppLocalizations.of(context)!
                      .translate("exportMeasurements"));
            },
          )
        ]);
  }
}
