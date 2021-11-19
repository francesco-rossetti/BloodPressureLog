import 'package:bloodpressurelog/domain/database/controllers/measurement_service.dart';
import 'package:bloodpressurelog/domain/database/models/measurement.dart';
import 'package:flutter/material.dart';

class MeasurementProvider extends ChangeNotifier {
  List<Measurement>? measurements;
  int filterLevel = 0;
  bool dbOperationStatus = false;

  MeasurementService? measurementService;

  MeasurementProvider() {
    measurementService = MeasurementService();
  }

  Future<void> readAll() async {
    measurements = await measurementService!.readAll();

    notifyListeners();
  }

  void changeFilter(int newFilterLevel) {
    filterLevel = newFilterLevel;

    readFilter();
  }

  Future<void> readFilter() async {
    measurements = await measurementService!.readFilter(filterLevel);

    notifyListeners();
  }

  Future<void> insert(Measurement measurement) async {
    dbOperationStatus = await measurementService!.insert(measurement);

    readFilter();
  }

  Future<void> update(Measurement measurement) async {
    dbOperationStatus = await measurementService!.update(measurement);

    readFilter();
  }

  Future<void> delete(Measurement measurement) async {
    dbOperationStatus = await measurementService!.delete(measurement);

    readFilter();
  }
}
