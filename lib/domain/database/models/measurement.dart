import 'dart:convert';

Measurement measurementFromJson(String str) =>
    Measurement.fromJson(json.decode(str));

String measurementToJson(Measurement data) => json.encode(data.toJson());

class Measurement {
  static const tableName = "measurement";

  Measurement({
    this.idMeasurement,
    this.dateTimeMeasurement,
    this.sysMeasurement,
    this.diaMeasurement,
    this.bpmMeasurement,
    this.oxygenationMesurement,
    this.notesMeasurement,
    this.tagMeasurement,
    this.dateInsert,
    this.dateUpdate,
    this.dateDelete,
  });

  int? idMeasurement;
  DateTime? dateTimeMeasurement;
  int? sysMeasurement;
  int? diaMeasurement;
  int? bpmMeasurement;
  int? oxygenationMesurement;
  String? notesMeasurement;
  String? tagMeasurement;
  DateTime? dateInsert;
  DateTime? dateUpdate;
  DateTime? dateDelete;

  factory Measurement.fromJson(Map<String, dynamic> json) => Measurement(
        idMeasurement: json["idMeasurement"],
        dateTimeMeasurement: DateTime.parse(json["dateTimeMeasurement"]),
        sysMeasurement: json["sysMeasurement"],
        diaMeasurement: json["diaMeasurement"],
        bpmMeasurement: json["bpmMeasurement"],
        oxygenationMesurement: json["oxygenationMesurement"],
        notesMeasurement: json["notesMeasurement"],
        tagMeasurement: json['tagMeasurement'],
        dateInsert: json["dateInsert"] != null
            ? DateTime.parse(json["dateInsert"])
            : null,
        dateUpdate: json["dateUpdate"] != null
            ? DateTime.parse(json["dateUpdate"])
            : null,
        dateDelete: json["dateDelete"] != null
            ? DateTime.parse(json["dateDelete"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "idMeasurement": idMeasurement,
        "dateTimeMeasurement": dateTimeMeasurement!.toIso8601String(),
        "sysMeasurement": sysMeasurement,
        "diaMeasurement": diaMeasurement,
        "bpmMeasurement": bpmMeasurement,
        "oxygenationMesurement": oxygenationMesurement,
        "notesMeasurement": notesMeasurement,
        "tagMeasurement": tagMeasurement,
        "dateInsert": dateInsert != null ? dateInsert!.toIso8601String() : null,
        "dateUpdate": dateUpdate != null ? dateUpdate!.toIso8601String() : null,
        "dateDelete": dateDelete != null ? dateDelete!.toIso8601String() : null,
      };
}
