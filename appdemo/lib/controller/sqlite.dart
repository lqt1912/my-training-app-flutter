// ignore_for_file: curly_braces_in_flow_control_structures, depend_on_referenced_packages, unused_import

import 'dart:io';

import 'package:appdemo/model/demo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE DEMO ("
          "id INTEGER PRIMARY KEY,"
          "author TEXT,"
          "text TEXT,"
          "status BIT"
          ")");
    });
  }

//Create (Khởi tạo)
  newClient(Demo newClient) async {
    final db = await database;
    var res = await db.insert("Demo", newClient.toMap());
    return res;
  }

  //Read
  getDemo(int id) async {
    final db = await database;
    var res = await db.query("Demo", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Demo.fromMap(res.first) : Null;
  }

  //Get all Clients với điều kiện

  getAllClients(String author) async {
    final db = await database;
    var res = await db.query(
      'Demo', // Tên bảng
      where: 'author = ?', // Điều kiện WHERE
      whereArgs: [author],
      orderBy: 'status', // Tham số cho điều kiện WHERE
    );
    List<Demo> list = res.isNotEmpty ? res.map((c) => Demo.fromMaSQl(c)).toList() : [];
    return list;
  }

  getAllClientsFilter(String author, int status) async {
    final db = await database;
    var res = await db.query(
      'Demo',
      where: 'author = ? AND status = ?',
      whereArgs: [author, status],
    );
    List<Demo> list = res.isNotEmpty ? res.map((c) => Demo.fromMaSQl(c)).toList() : [];
    return list;
  }

  // VD:
  // getBlockedClients() async {
  //   final db = await database;
  //   var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
  //   List<Client> list =
  //       res.isNotEmpty ? res.toList().map((c) => Client.fromMap(c)) : null;
  //   return list;
  // }

  //Update
  updateDemo(Demo newClient) async {
    final db = await database;
    var res = await db.update("Demo", newClient.toMap(), where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }

  //Delete
  deleteDemo(int id) async {
    final db = await database;
    db.delete("Demo", where: "id = ?", whereArgs: [id]);
  }

  //delete all
  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Demo");
  }
}
