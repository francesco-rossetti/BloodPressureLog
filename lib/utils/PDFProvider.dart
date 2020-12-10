import 'dart:io';

import 'package:bloodpressurelog/utils/AppLocalization.dart';
import 'package:bloodpressurelog/utils/database/controllers/measurementService.dart';
import 'package:bloodpressurelog/utils/database/models/measurement.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import '../constants.dart';

class PDFProvider {
  static pw.Document initDocument() {
    final pdf = pw.Document(deflate: zlib.encode);

    return pdf;
  }

  static Future<Directory> getPath() async {
    Directory documentsDirectory;
    if (Platform.isAndroid)
      documentsDirectory = await getExternalStorageDirectory();
    else if (Platform.isIOS)
      documentsDirectory = await getApplicationDocumentsDirectory();

    return documentsDirectory;
  }

  static Future<String> pdfMeasurementPeriod(
      BuildContext context, int period) async {
    List<Measurement> aziende = await MeasurementService().readFilter(period);

    if (aziende.length > 0) {
      final pdf = initDocument();

      String periodName = "";
      String date = "";

      switch (period) {
        case 0:
          periodName = "week";
          date = langFormatDateOnly(
                  context, DateTime.now().subtract(Duration(days: 7))) +
              " - " +
              langFormatDateOnly(context, DateTime.now());
          break;
        case 1:
          periodName = "month";
          date = langFormatDateOnly(
                  context, DateTime.now().subtract(Duration(days: 30))) +
              " - " +
              langFormatDateOnly(context, DateTime.now());
          break;
        case 2:
          periodName = "year";
          date = langFormatDateOnly(
                  context, DateTime.now().subtract(Duration(days: 365))) +
              " - " +
              langFormatDateOnly(context, DateTime.now());
          break;
        case 3:
          periodName = "all";
          date = AppLocalizations.of(context).translate("allDates");
          break;
      }

      String moduleName = AppLocalizations.of(context).translate("appName") +
          " | " +
          AppLocalizations.of(context).translate(periodName);

      pdf.addPage(pw.MultiPage(
          orientation: pw.PageOrientation.landscape,
          theme: pw.ThemeData.withFont(
            base: pw.Font.ttf(
                await rootBundle.load("assets/fonts/Rubik-Regular.ttf")),
            bold: pw.Font.ttf(
                await rootBundle.load("assets/fonts/Rubik-Bold.ttf")),
            italic: pw.Font.ttf(
                await rootBundle.load("assets/fonts/Rubik-Italic.ttf")),
            boldItalic: pw.Font.ttf(
                await rootBundle.load("assets/fonts/Rubik-BoldItalic.ttf")),
          ),
          build: (c) => [
                pw.Center(
                    child: pw.Text(moduleName,
                        style: pw.TextStyle(
                            fontSize: 25, fontWeight: pw.FontWeight.bold))),
                pw.Text("\n\n\n"),
                pw.Table.fromTextArray(context: c, data: <List<String>>[
                  <String>[
                    AppLocalizations.of(context).translate("dateMeasurement"),
                    AppLocalizations.of(context).translate("sys"),
                    AppLocalizations.of(context).translate("dia"),
                    AppLocalizations.of(context).translate("bpm"),
                    AppLocalizations.of(context).translate("oxygenationLevel"),
                    AppLocalizations.of(context).translate("note")
                  ],
                  ...aziende.map((item) => [
                        langFormatDate(context, item.dateTimeMeasurement),
                        item.sysMeasurement.toString(),
                        item.diaMeasurement.toString(),
                        item.bpmMeasurement.toString(),
                        item.oxygenationMesurement != null
                            ? item.oxygenationMesurement.toString() + "%"
                            : "",
                        item.notesMeasurement
                      ])
                ]),
                pw.Text("\n"),
                pw.Text(AppLocalizations.of(context)
                        .translate("informationDateTime") +
                    date),
              ]));

      String dir = (await getPath()).path;
      dir = "$dir/output";

      String path =
          "$dir/$moduleName" + "_" + DateTime.now().toString() + ".pdf";
      File file = File(path);

      var dir2check = Directory(dir);

      bool dirExists = await dir2check.exists();
      if (!dirExists) {
        await dir2check.create();
      }

      await file.writeAsBytes(pdf.save());

      return path;
    } else {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context).translate("noValuesDetected") +
              "\n" +
              AppLocalizations.of(context).translate("noValuesDetectedDetail"),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);

      return null;
    }
  }
}
