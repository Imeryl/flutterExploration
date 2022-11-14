import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Future<void> insert(String table, Map<String, Object> data) async {
    final dbPath = await getDatabasesPath();
    final db =
        await openDatabase(join(dbPath, 'places.db'), onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE places(id TEXT PRIMARY KEY, name TEXT, image TEXT)');
    }, version: 1);

    await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
