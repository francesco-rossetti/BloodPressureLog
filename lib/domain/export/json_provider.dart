import 'dart:convert';
import 'dart:io';

import 'package:bloodpressurelog/domain/database/controllers/measurement_service.dart';
import 'package:bloodpressurelog/domain/database/models/measurement.dart';
import 'package:path_provider/path_provider.dart';

class JSONProvider {
  static Future<Directory?> getPath() async {
    Directory? documentsDirectory;
    if (Platform.isAndroid) {
      documentsDirectory = await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      documentsDirectory = await getApplicationDocumentsDirectory();
    }

    return documentsDirectory;
  }

  static Future<String> exportMeasurements() async {
    List<Measurement> measurements = await MeasurementService().readAll();

    String contents = jsonEncode(measurements);

    String dir = (await getPath())!.path;
    dir = "$dir/output";

    String path = "$dir/export_" + DateTime.now().toString() + ".json";
    File file = File(path);

    var dir2check = Directory(dir);

    bool dirExists = await dir2check.exists();
    if (!dirExists) {
      await dir2check.create();
    }

    await file.writeAsBytes(utf8.encode(contents));

    return path;
  }

  static Future<void> importMeasurements(String path) async {
    String contents = File(path).readAsStringSync();

    List<dynamic> map = jsonDecode(contents);

    List<Measurement> result = [];

    for (var element in map) {
      result.add(Measurement.fromJson(element));
    }

    await MeasurementService().insertBulk(result);
  }
}
