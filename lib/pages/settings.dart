import 'package:bloodpressurelog/components/on_boarding.dart';
import 'package:bloodpressurelog/components/page_sample.dart' as components;
import 'package:bloodpressurelog/constants.dart';
import 'package:bloodpressurelog/domain/export/json_provider.dart';
import 'package:bloodpressurelog/domain/lang/app_localization.dart';
import 'package:bloodpressurelog/pages/info.dart';
import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  createBody() {
    return ListView(children: [
      const SizedBox(height: 20),
      Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
          child: SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  var path = await JSONProvider.exportMeasurements();
                  Share.shareFiles([path],
                      subject: AppLocalizations.of(context)!
                          .translate("importMeasurements")!);
                },
                child: Text(
                    AppLocalizations.of(context)!
                        .translate("exportMeasurements")!,
                    style: const TextStyle(fontSize: 20)),
              ))),
      Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
          child: SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  FilePickerResult? file =
                      await FilePicker.platform.pickFiles(type: FileType.any);

                  if (file != null && file.files.isNotEmpty) {
                    JSONProvider.importMeasurements(file.files.first.path!);
                  }
                },
                child: Text(
                    AppLocalizations.of(context)!
                        .translate("importMeasurements")!,
                    style: const TextStyle(fontSize: 20)),
              ))),
      const SizedBox(height: 20),
      Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
          child: SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const IntroScreen(isReplay: true)));
                },
                child: Text(
                    AppLocalizations.of(context)!.translate("instruction")!,
                    style: const TextStyle(fontSize: 20)),
              ))),
      Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  await launch(kSourcesURL);
                },
                child: Text(AppLocalizations.of(context)!.translate("sources")!,
                    style: const TextStyle(fontSize: 20)),
              ))),
      const SizedBox(height: 20),
      Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  await launch(kDevURL);
                },
                child: Text(AppLocalizations.of(context)!.translate("myApp")!,
                    style: const TextStyle(fontSize: 20)),
              ))),
      const SizedBox(height: 20),
    ]);
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
        name: "settings",
        body: createBody(),
        showBottomBar: true,
        appBarActions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () async {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const InfoPage()));
            },
          )
        ]);
  }
}
