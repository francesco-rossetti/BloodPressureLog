import 'package:admob_flutter/admob_flutter.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloodpressurelog/components/pressure_level_bar.dart';
import 'package:bloodpressurelog/utils/app_localization.dart';
import 'package:bloodpressurelog/utils/database/controllers/measurement_service.dart';
import 'package:bloodpressurelog/utils/database/models/measurement.dart';
import 'package:flutter/material.dart';
import 'package:bloodpressurelog/components/page_sample.dart' as components;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'constants.dart';

class UpdateRecord extends StatefulWidget {
  final Measurement? measurement;

  const UpdateRecord({Key? key, @required this.measurement}) : super(key: key);

  @override
  _UpdateRecordState createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
  AdmobInterstitial? interstitialAd;
  final TextEditingController noteController = TextEditingController();
  final TextEditingController oxygenationController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  static int sysRecord = 100, diaRecord = 70, bpmRecord = 60;
  static DateTime dateTimeRecord = DateTime.now();

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

    interstitialAd = AdmobInterstitial(
      adUnitId: kInterstitialID,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) {
          Navigator.of(context).pop();
        }
      },
    );

    interstitialAd!.load();
  }

  createBody(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        children: [
          kbanner,
          const SizedBox(height: 20),
          PressureLevelBar(sysRecord: sysRecord, diaRecord: diaRecord),
          const SizedBox(height: 10),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 10),
                Expanded(
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                      Column(children: [
                        Text(AppLocalizations.of(context)!.translate("sys")!,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
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
                        Text(AppLocalizations.of(context)!.translate("dia")!,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
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
                        Text(AppLocalizations.of(context)!.translate("bpm")!,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
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

                  MeasurementService measurementService = MeasurementService();

                  var result =
                      await measurementService.update(widget.measurement!);

                  if (result) {
                    setState(() {
                      _btnController.success();
                    });

                    AwesomeDialog(
                      context: context,
                      desc: AppLocalizations.of(context)!
                          .translate("updaateConfirmation"),
                      title: "",
                      btnOkOnPress: () => showInterstitialAD(),
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

  showInterstitialAD() async {
    if (await interstitialAd!.isLoaded != null) {
      bool? checked = await interstitialAd!.isLoaded;

      if (checked!) interstitialAd!.show();
    } else {
      setState(() {
        _btnController.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return components.Page(
        name: "updateValue",
        body: createBody(context),
        showBottomBar: false,
        appBarActions: [
          widget.measurement != null
              ? IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white),
                  onPressed: () async {
                    bool result =
                        await MeasurementService().delete(widget.measurement!);
                    if (result) {
                      Navigator.pop(context);
                    }
                  },
                )
              : Container()
        ]);
  }
}
