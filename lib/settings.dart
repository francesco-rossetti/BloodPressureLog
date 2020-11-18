import 'package:bloodpressurelog/components/pageSample.dart' as components;
import 'package:bloodpressurelog/utils/AppLocalization.dart';
import 'package:bloodpressurelog/utils/JSONProvider.dart';
import 'package:bloodpressurelog/utils/PDFProvider.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  createBody(BuildContext context) {
    return ListView(children: [
      Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: SizedBox(
              width: double.infinity,
              height: 40,
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () async {
                  var path = await PDFProvider.pdfAziende(context);
                  Share.shareFiles([path],
                      subject: AppLocalizations.of(context)
                          .translate("exportMeasurements"));
                },
                child: new Text(
                    AppLocalizations.of(context)
                            .translate("exportMeasurements") +
                        " PDF",
                    style: TextStyle(fontSize: 20)),
              ))),
      SizedBox(height: 20),
      Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: SizedBox(
              width: double.infinity,
              height: 40,
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () async {
                  var path = await JSONProvider.exportMeasurements();
                  Share.shareFiles([path],
                      subject: AppLocalizations.of(context)
                          .translate("importMeasurements"));
                },
                child: new Text(
                    AppLocalizations.of(context)
                        .translate("exportMeasurements"),
                    style: TextStyle(fontSize: 20)),
              ))),
      Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: SizedBox(
              width: double.infinity,
              height: 40,
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () async {
                  var result = [];

                  if (result != null) {
                    //JSONProvider.importMeasurements(result.files.single.path);
                  } else {
                    // User canceled the picker
                  }
                },
                child: new Text(
                    AppLocalizations.of(context)
                        .translate("importMeasurements"),
                    style: TextStyle(fontSize: 20)),
              ))),
      SizedBox(height: 20),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return components.Page(
        name: "settings", showBottomBar: true, body: createBody(context));
  }
}
