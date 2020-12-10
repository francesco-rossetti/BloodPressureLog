import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  createDatabase(Database db, int version) async {
    db.execute("CREATE TABLE \"tagmeasurement\" ("
        "\"idTagMeasurement\"	INTEGER NOT NULL UNIQUE,"
        "\"descriptionTagMeasurement\" TEXT NOT NULL,"
        "\"dateInsert\"	DATETIME,"
        "\"dateUpdate\"	DATETIME,"
        "\"dateDelete\"	DATETIME,"
        "PRIMARY KEY(\"idTagMeasurement\" AUTOINCREMENT));");

    db.execute("CREATE TABLE \"measurement\" ("
        "\"idMeasurement\"	INTEGER NOT NULL UNIQUE,"
        "\"dateTimeMeasurement\"	DATETIME NOT NULL,"
        "\"sysMeasurement\"	INTEGER NOT NULL,"
        "\"diaMeasurement\"	INTEGER NOT NULL,"
        "\"bpmMeasurement\"	INTEGER NOT NULL,"
        "\"oxygenationMesurement\" INTEGER,"
        "\"notesMeasurement\" TEXT,"
        "\"tagMeasurement\"	TEXT,"
        "\"dateInsert\"	DATETIME,"
        "\"dateUpdate\"	DATETIME,"
        "\"dateDelete\"	DATETIME,"
        "PRIMARY KEY(\"idMeasurement\" AUTOINCREMENT));");
  }

  initDB() async {
    Directory databaseDirectory;
    if (Platform.isAndroid)
      databaseDirectory = await getExternalStorageDirectory();
    else if (Platform.isIOS)
      databaseDirectory = await getApplicationDocumentsDirectory();

    String path = join(databaseDirectory.path, "BloodPressureLog.db");

    return await openDatabase(path,
        version: 1,
        onOpen: (db) {},
        onCreate: createDatabase,
        onUpgrade: upgradeDatabase);
  }

  void upgradeDatabase(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {}
  }
}
