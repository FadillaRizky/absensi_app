
import 'dart:io';
import 'package:absensi_app/profile_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProfile {
  final String databaseName = "my_database.db";
  final int databaseVersion = 1;

  final String table = "profile";

  final String id = "id";
  final String name = "name";
  final String nik = "nik";
  final String bod = "bod";
  final String position = "position";
  final String address = "address";

  Database? _database;

  Future<Database> database() async {
    if (_database != null)
      return _database!;
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
        'CREATE TABLE $table ($id INTEGER PRIMARY KEY, $name TEXT NULL , $nik TEXT NULL,$bod TEXT NULL,$position TEXT NULL,$address TEXT NULL)');
  }

  Future<List<ProfileModel>> all() async {
    final data = await _database!.query(table);
    List<ProfileModel> result =
    data.map((e) => ProfileModel.fromJson(e)).toList();
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
