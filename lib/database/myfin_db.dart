// ignore_for_file: prefer_conditional_assignment

import 'dart:async';
import 'dart:collection';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:myfin/models/stock.dart';//try move to separate

class MyFinDB {
  static final MyFinDB dbInstance = MyFinDB._createInstance(); //Singleton pattern, so use this dbinstance to do everything in this class
  static Database? _database;

  MyFinDB._createInstance(); //private constructor

  Future<Database> get database async {//gets the db async from other calls
    if (_database == null) {
        _database = await _initDB('myfin.db');
    }
    return _database!;//! is an assert
  }

  Future<Database> _initDB(String filename) async {
    final dbPath = await getDatabasesPath();// /data/user/0/com.example.myfin/databases
    final path = join(dbPath, filename);
    return await openDatabase(path, version: 2, onCreate: _createDB, onUpgrade: _upgradeDB);//increase version number when want to do onUpgrade
  }

  Future<void>_createDB(Database db, int version) async { //passing in a function when onCreate
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

  Future<void> close() async {
    final db = await dbInstance.database;
    db.close();
  }
}