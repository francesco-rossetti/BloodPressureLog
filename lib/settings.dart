import 'dart:io';

import 'package:bloodpressurelog/components/onBoarding.dart';
import 'package:bloodpressurelog/components/pageSample.dart' as components;
import 'package:bloodpressurelog/constants.dart';
import 'package:bloodpressurelog/utils/AppLocalization.dart';
import 'package:bloodpressurelog/utils/JSONProvider.dart';
import 'package:commons/commons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  createBody(BuildContext context) {
    return ListView(children: [
      SizedBox(height: 20),
      Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 0),
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
          padding: EdgeInsets.only(left: 15, right: 15, top: 5),
          child: SizedBox(
              width: double.infinity,
              height: 40,
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () async {
                  File file = await FilePicker.getFile(type: FileType.any);

                  if (file != null) {
                    JSONProvider.importMeasurements(file.path);
                  }
                },
                child: new Text(
                    AppLocalizations.of(context)
                        .translate("importMeasurements"),
                    style: TextStyle(fontSize: 20)),
              ))),
      SizedBox(height: 20),
      Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 5),
          child: SizedBox(
              width: double.infinity,
              height: 40,
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => IntroScreen(isReplay: true)));
                },
                child: new Text(
                    AppLocalizations.of(context).translate("instruction"),
                    style: TextStyle(fontSize: 20)),
              ))),
      Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 5),
          child: SizedBox(
              width: double.infinity,
              height: 40,
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () async {
                  if (await inAppReview.isAvailable()) {
                    inAppReview.requestReview();
                  }
                },
                child: new Text(
                    AppLocalizations.of(context).translate("rateApp"),
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
                  if (await canLaunch(kDevURL)) await launch(kDevURL);
                },
                child: new Text(AppLocalizations.of(context).translate("myApp"),
                    style: TextStyle(fontSize: 20)),
              ))),
      SizedBox(height: 20),
      kLargeBanner
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return components.Page(
        name: "settings", showBottomBar: true, body: createBody(context));
  }
}
