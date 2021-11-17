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

class AddRecordPage extends StatefulWidget {
  const AddRecordPage({Key? key}) : super(key: key);

  @override
  _AddRecordPageState createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
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
                const SizedBox(height: 20),
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
                  Measurement measurement = Measurement();
                  measurement.bpmMeasurement = bpmRecord;
                  measurement.dateTimeMeasurement = dateTimeRecord;
                  measurement.diaMeasurement = diaRecord;
                  measurement.notesMeasurement = noteController.text;
                  measurement.sysMeasurement = sysRecord;
                  measurement.oxygenationMesurement =
                      oxygenationController.text.isNotEmpty
                          ? int.parse(oxygenationController.text)
                          : null;

                  MeasurementProvider provider =
                      Provider.of<MeasurementProvider>(context, listen: false);

                  await provider.insert(measurement);

                  if (provider.dbOperationStatus) {
                    setState(() {
                      _btnController.success();
                    });

                    AwesomeDialog(
                      context: context,
                      desc: AppLocalizations.of(context)!
                          .translate("insertConfirmation"),
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
  Widget build(BuildContext context) {
    return components.Page(
      name: "addValue",
      body: createBody(),
      showBottomBar: true,
      appBarActions: const [],
    );
  }
}
