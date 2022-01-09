// ignore_for_file: prefer_conditional_assignment

import 'dart:async';
import 'dart:collection';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:myfin/models/stock.dart';//try move to separate

class MyFinDB {
  static final MyFinDB dbInstance = MyFinDB._createInstance(); //? Singleton pattern, so use this dbinstance to do everything in this class
  static Database? _database;

  MyFinDB._createInstance() {
    //print("create instance");//works
  } //private constructor

  Future<Database> get database async {//gets the db async from other calls
    //print("get");//works
    if (_database == null) {
        //print("b4 init");
        _database = await _initDB('myfin.db');
        //print("after init");
    }
    //print("db not null");//comes here so is not null
    //print(await getDatabasesPath());
    return _database!;//! is an assert
  }

  Future<Database> _initDB(String filename) async {//not exiting after this using emulator
    final dbPath = await getDatabasesPath();// /data/user/0/com.example.myfin/databases
    final path = join(dbPath, filename);
    //print("in init, path: " + path);
    return await openDatabase(path, version: 2, onCreate: _createDB, onUpgrade: _upgradeDB);//increase version number when want to do onUpgrade
  }

  Future<void>_createDB(Database db, int version) async { //passing in a function when onCreate
    //print("in db creation");
    //await db.execute("DROP TABLE IF EXISTS stocks");
    await db.execute(
      '''CREATE TABLE IF NOT EXISTS stocks(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        symbol VARCHAR(8) NOT NULL,
        bought_price DOUBLE NOT NULL,
        bought_date DATE NOT NULL,
        brokerage TEXT NOT NULL,
        lots INTEGER NOT NULL,
        sold_price DOUBLE,
        sold_date DOUBLE
      )'''
    );
    //print("successful create db");
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (newVersion > oldVersion) {
      await db.execute(
        '''
        ALTER TABLE stocks
        ADD is_US BOOLEAN NOT NULL DEFAULT 1
        '''
      );
      //ALTER TABLE stocks //just cant seem to change this for some reason
      //  RENAME COLUMN lots TO shares
    }
  }

  /*Future<int> insertStock(Stock stock) async {
    final db = await dbInstance.database;
    final id = await db.insert('stocks', stock.toMap());
    stock.setId(id);
    //print("inserted stock");
    return id;
  }

  Future<Stock> readStock(int id) async {
    final db = await dbInstance.database;
    List<Map<String, dynamic>> maps = await db.query(
      'stocks',
      where: 'id = ?',
      whereArgs: [id],
      );
    Stock stock = Stock.fromDB(maps[0]); //shld not be empty, can add a check and throw exception if empty later. will be empty if invalid id
    return stock;
  }

  Future<Map<String, dynamic>> readStockMap(int id) async {
    final db = await dbInstance.database;
    List<Map<String, dynamic>> maps = await db.query(
      'stocks',
      where: 'id = ?',
      whereArgs: [id],
      );
    //print(maps.length);
    return maps[0];
  }

  Future<List<Stock>> readAllStocks() async {
    //print("read all stocks");
    final db = await dbInstance.database;
    final List<Map<String, dynamic>> maps = await db.query('stocks');
    //print("length maps ${maps.length}");
    List<Stock> stocks = maps.map((map) => Stock.fromDB(map)).toList();//here
    for (Stock stock in stocks) {
      if (stock.sold_price == null) {
        await stock.getCurrPrice();
      }
    }
    //print("end read all stocks");
    return stocks; 
  }
  
  Future<void> updateStock(Stock stock) async {//works
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

  Future<void> deleteStockById(int id) async {
    final db = await dbInstance.database;
    db.delete(
      'stocks',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<double?> getTotalInvestments() async {
    final db = await dbInstance.database;
    List<Map<String, Object?>> map = await db.rawQuery('''
      SELECT SUM(bought_price * lots)
      FROM stocks
      WHERE sold_price IS NULL;
    ''');
    Object? totalInvestments = map[0]["SUM(bought_price * lots)"];//the return value has the key as the columns
    if (totalInvestments == null) {
      return null;
    } 
    return totalInvestments! as double;
  }*/

  Future<void> close() async {
    final db = await dbInstance.database;
    db.close();
  }
}