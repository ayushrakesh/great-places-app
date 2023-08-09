import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();

    print(dbPath);
    print(path.join(dbPath, 'great-places.db'));

    return sql.openDatabase(
      path.join(dbPath, 'great-places.db'),
      onCreate: (db, version) => {
        db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT)',
        ),
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    print(table);

    return db.query(table);
  }
}
