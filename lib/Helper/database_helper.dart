import 'dart:core';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('bookmarks.db');
    return _database!;
  }

  Future initDB() async {
    await database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bookmarks (
        id INTEGER PRIMARY KEY,
        title TEXT,
        price REAL,
        description TEXT,
        category TEXT,
        image TEXT
      )
    ''');
  }

  Future insertBookmark(Map<String, Object?> Modelproduct) async {
    final db = await instance.database;
    return await db.insert('bookmarks', Modelproduct, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future deleteBookmark(int id) async {
    final db = await instance.database;
    return await db.delete('bookmarks', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getBookmarks() async {
    final db = await instance.database;
    return await db.query('bookmarks');
  }
}