
import 'dart:io';
import 'package:absensi_app/models/absen_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseAbsensi {
  final String databaseName = "my_database_absen.db";
  final int databaseVersion = 1;

  final String table = "absensi";

  final String id = "id";
  final String today = "today";
  final String comeIn = "come_in";
  final String comeOut = "come_out";

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
        'CREATE TABLE $table ($id INTEGER PRIMARY KEY, $today TEXT NULL , $comeIn TEXT NULL,$comeOut TEXT NULL)');
  }

  // Future<List<AbsenModel>> all() async {
  //   final data = await _database!.query(table);
  //   List<AbsenModel> result =
  //   data.map((e) => AbsenModel.fromJson(e)).toList();
  //   return result;
  // }

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
