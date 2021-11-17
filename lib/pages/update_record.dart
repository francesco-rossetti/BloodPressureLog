// ignore_for_file: must_be_immutable

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloodpressurelog/components/page_sample.dart' as components;
import 'package:bloodpressurelog/components/pressure_level_bar.dart';
import 'package:bloodpressurelog/constants.dart';
import 'package:bloodpressurelog/domain/database/models/measurement.dart';
import 'package:bloodpressurelog/domain/lang/app_localization.dart';
import 'package:bloodpressurelog/domain/providers/measurement_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class UpdateRecordPage extends StatefulWidget {
  Measurement? measurement;

  UpdateRecordPage({Key? key, this.measurement}) : super(key: key);

  @override
  _UpdateRecordPageState createState() => _UpdateRecordPageState();
}

class _UpdateRecordPageState extends State<UpdateRecordPage> {
  final TextEditingController noteController = TextEditingController();
  final TextEditingController oxygenationController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  static int sysRecord = 100, diaRecord = 70, bpmRecord = 60;
  static DateTime dateTimeRecord = DateTime.now();

  createBody() {
    return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        children: [
          const SizedBox(height: 20),
          PressureLevelBar(sysRecord: sysRecord, diaRecord: diaRecord),
          const SizedBox(height: 10),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 10),
                SizedBox(
                    height: 200,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          Column(children: [
                            Text(
                                AppLocalizations.of(context)!.translate("sys")!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            const Text("mmHg",
                                style: TextStyle(fontStyle: FontStyle.italic)),
                            const SizedBox(height: 10),
                            NumberPicker(
                                value: sysRecord,
                                minValue: 20,
                                maxValue: 200,
                                onChanged: (value) {
                                  sysRecord = value;
                                  setState(() {});
                                }),
                          ]),
                          Column(children: [
                            Text(
                                AppLocalizations.of(context)!.translate("dia")!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            const Text("mmHg",
                                style: TextStyle(fontStyle: FontStyle.italic)),
                            const SizedBox(height: 10),
                            NumberPicker(
                                value: diaRecord,
                                minValue: 20,
                                maxValue: 200,
                                onChanged: (value) {
                                  diaRecord = value;
                                  setState(() {});
                                }),
                          ]),
                          Column(children: [
                            Text(
                                AppLocalizations.of(context)!.translate("bpm")!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            const Text("bpm",
                                style: TextStyle(fontStyle: FontStyle.italic)),
                            const SizedBox(height: 10),
                            NumberPicker(
                                value: bpmRecord,
                                minValue: 20,
                                maxValue: 200,
                                onChanged: (value) {
                                  bpmRecord = value;
                                  setState(() {});
                                }),
                          ]),
                        ])),
              ],
            ),
          ),
          TextFormField(
            controller: oxygenationController,
            keyboardType: TextInputType.number,
            onSaved: (String? val) {},
            decoration: InputDecoration(
              icon: const Icon(Icons.biotech),
              labelText:
                  AppLocalizations.of(context)!.translate("oxygenationLevel"),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: ElevatedButton(
                  onPressed: () {
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true, onChanged: (date) {
                      setState(() {
                        dateTimeRecord = date;
                      });
                    }, onConfirm: (date) {
                      setState(() {
                        dateTimeRecord = date;
                      });
                    },
                        currentTime: dateTimeRecord,
                        locale:
                            AppLocalizations.of(context)!.locale.languageCode ==
                                    "it"
                                ? LocaleType.it
                                : LocaleType.en);
                  },
                  child: ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: Text(AppLocalizations.of(context)!
                        .translate("selectDateTime")!),
                    subtitle: Text(langFormatDate(context, dateTimeRecord)),
                  ))),
          const SizedBox(height: 20),
          TextFormField(
            controller: noteController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            onSaved: (String? val) {},
            decoration: InputDecoration(
              icon: const Icon(Icons.note_add),
              labelText: AppLocalizations.of(context)!.translate("note"),
            ),
          ),
          const SizedBox(height: 20),
          RoundedLoadingButton(
              child: Text(AppLocalizations.of(context)!.translate("confirm")!,
                  style: const TextStyle(color: Colors.white)),
              controller: _btnController,
              onPressed: () async {
                try {
                  widget.measurement!.bpmMeasurement = bpmRecord;
                  widget.measurement!.dateTimeMeasurement = dateTimeRecord;
                  widget.measurement!.diaMeasurement = diaRecord;
                  widget.measurement!.notesMeasurement = noteController.text;
                  widget.measurement!.sysMeasurement = sysRecord;
                  widget.measurement!.oxygenationMesurement =
                      oxygenationController.text.isNotEmpty
                          ? int.parse(oxygenationController.text)
                          : null;

                  MeasurementProvider provider =
                      Provider.of<MeasurementProvider>(context, listen: false);

                  await provider.update(widget.measurement!);

                  if (provider.dbOperationStatus) {
                    setState(() {
                      _btnController.success();
                    });

                    AwesomeDialog(
                      context: context,
                      desc: AppLocalizations.of(context)!
                          .translate("updaateConfirmation"),
                      title: "",
                      //btnOkOnPress: () => showInterstitialAD(),
                    ).show();

                    await Future.delayed(const Duration(seconds: 3));

                    setState(() {
                      _btnController.reset();
                    });
                  } else {
                    setState(() {
                      _btnController.error();
                    });

                    await Future.delayed(const Duration(seconds: 3));

                    setState(() {
                      _btnController.reset();
                    });
                  }
                } catch (e) {
                  setState(() {
                    _btnController.error();
                  });

                  await Future.delayed(const Duration(seconds: 3));

                  setState(() {
                    _btnController.reset();
                  });
                }
              }),
        ]);
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();

    sysRecord = widget.measurement!.sysMeasurement!;
    diaRecord = widget.measurement!.diaMeasurement!;
    bpmRecord = widget.measurement!.bpmMeasurement!;
    noteController.text = widget.measurement!.notesMeasurement!;
    dateTimeRecord = widget.measurement!.dateTimeMeasurement!;
    oxygenationController.text =
        widget.measurement!.oxygenationMesurement != null
            ? widget.measurement!.oxygenationMesurement.toString()
            : "";

/*     interstitialAd = AdmobInterstitial(
      adUnitId: kInterstitialID,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) {
          Navigator.of(context).pop();
        }
      },
    );

    interstitialAd!.load(); */
  }

  @override
  Widget build(BuildContext context) {
    return components.Page(
        name: "updateValue",
        body: createBody(),
        showBottomBar: false,
        appBarActions: [
          widget.measurement != null
              ? IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white),
                  onPressed: () async {
                    MeasurementProvider provider =
                        Provider.of<MeasurementProvider>(context,
                            listen: false);

                    await provider.delete(widget.measurement!);

                    if (provider.dbOperationStatus) {
                      Navigator.pop(context);
                    }
                  },
                )
              : Container()
        ]);
  }
}
