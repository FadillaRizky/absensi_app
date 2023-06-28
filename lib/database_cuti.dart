
import 'dart:io';
import 'package:absensi_app/cuti_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseCuti {
  final String databaseName = "my_database_cuti.db";
  final int databaseVersion = 1;

  final String table = "absensi";

  final String id = "id";
  final String startCuti = "start_cuti";
  final String endCuti = "end_cuti";

  Database? _database;

  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    return openDatabase(path, version: databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $table ($id INTEGER PRIMARY KEY, $startCuti TEXT NULL , $endCuti TEXT NULL)');
  }

  Future<List<CutiModel>> all() async {
    final data = await _database!.query(table);
    List<CutiModel> result =
    data.map((e) => CutiModel.fromJson(e)).toList();
    return result;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final query = await _database!.insert(table, row);
    return query;
  }

  Future<int> update(int idParam, Map<String, dynamic> row) async {
    final query = await _database!
        .update(table, row, where: '$id = ?', whereArgs: [idParam]);
    return query;
  }

  Future delete(int idParam) async {
    await _database!.delete(table, where: '$id = ?', whereArgs: [idParam]);
  }
}
