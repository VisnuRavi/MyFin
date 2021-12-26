// ignore_for_file: prefer_conditional_assignment

import 'dart:async';
import 'dart:collection';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:myfin/models/stock.dart';//try move to separate

class MyFinDB {
  static final MyFinDB dbInstance = MyFinDB._createInstance(); //?
  static Database? _database;

  MyFinDB._createInstance(); //private constructor

  Future<Database> get database async {//gets the db async from other calls
    if (_database == null) {
        _database = await _initDB('myfin.db');
    }
    return _database!;//! is an assert
  }

  Future<Database> _initDB(String filename) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filename);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void>_createDB(Database db, int version) async { //passing in a function when onCreate
    db.execute(
      '''CREATE TABLE stocks(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        symbol VARCHAR(8) NOT NULL,
        bought_price DOUBLE NOT NULL,
        bought_date DATE NOT NULL,
        brokerage TEXT NOT NULL,
        sold_price DOUBLE,
        sold_date DOUBLE,
      )'''
    );
  }

  Future<void> insertStock(Stock stock) async {
    final db = await dbInstance.database;
    final id = await db.insert('stocks', stock.toMap());
    stock.setId(id);
  }

  Future<Stock> readStock(int id) async {
    final db = await dbInstance.database;
    List<Map<String, dynamic>> maps = await db.query(
      'stocks',
      where: 'id = ?',
      whereArgs: [id],
      );
    Stock stock = Stock.fromDB(maps[0]);
    return stock;
  }

  Future<List<Stock>> readAllStocks() async {
    final db = await dbInstance.database;
    final List<Map<String, dynamic>> maps = await db.query('stocks');
    List<Stock> stocks = maps.map((map) => Stock.fromDB(map)).toList();
    return stocks; 
  }
  
  Future<void> updateStock(Stock stock) async {
    final db = await dbInstance.database;
    db.update(
      'stocks',
      stock.toMap(),
      where: "id = ?",
      whereArgs: [stock.id],
    );
  }

  Future<void> deleteStock(Stock stock) async {
    final db = await dbInstance.database;
    db.delete(
      'stocks',
      where: "id = ?",
      whereArgs: [stock.id],
    );
  }


  Future<void> close() async {
    final db = await dbInstance.database;
    db.close();
  }
}