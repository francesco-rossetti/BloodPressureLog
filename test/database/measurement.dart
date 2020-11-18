import 'package:bloodpressurelog/utils/database/controllers/measurementService.dart';
import 'package:bloodpressurelog/utils/database/models/measurement.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Measurement", () {
    test("insert", () async {
      Measurement test = new Measurement();
      test.bpmMeasurement = 120;
      test.dateTimeMeasurement = DateTime.now();
      test.notesMeasurement = "inserted";
      test.diaMeasurement = 60;
      test.sysMeasurement = 110;

      var result = await MeasurementService().insert(test);

      expect(result, true);
    });

    test("update", () async {
      MeasurementService service = MeasurementService();

      var test = await service.readByID(1);
      test.bpmMeasurement = 1200;
      test.dateTimeMeasurement = DateTime.now();
      test.diaMeasurement = 1200;
      test.sysMeasurement = 1200;
      test.notesMeasurement = "updated";

      var result = await service.update(test);

      expect(result, true);
    });

    test("readAll", () async {
      var list = await MeasurementService().readAll();

      expect((list.length > 0), true);
    });

    test("readByID", () async {
      var result = await MeasurementService().readByID(1);

      expect(result.idMeasurement, 1);
    });

    test("delete", () async {
      MeasurementService service = MeasurementService();

      var test = await service.readByID(1);

      var result = await service.delete(test);

      expect(result, true);
    });
  });
}
