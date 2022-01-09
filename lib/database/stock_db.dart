import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:myfin/models/stock.dart';//try move to separate
import 'package:myfin/database/myfin_db.dart';

class StockDB {
  static final StockDB stockFns = StockDB._createInstance();

  StockDB._createInstance();

  Future<int> insertStock(Stock stock) async {
    final db = await MyFinDB.dbInstance.database;
    final id = await db.insert('stocks', stock.toMap());
    stock.setId(id);
    //print("inserted stock");
    return id;
  }

  Future<Stock> readStock(int id) async {
    final db = await MyFinDB.dbInstance.database;
    List<Map<String, dynamic>> maps = await db.query(
      'stocks',
      where: 'id = ?',
      whereArgs: [id],
      );
    Stock stock = Stock.fromDB(maps[0]); //shld not be empty, can add a check and throw exception if empty later. will be empty if invalid id
    return stock;
  }

  Future<Map<String, dynamic>> readStockMap(int id) async {
    final db = await MyFinDB.dbInstance.database;
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
    final db = await MyFinDB.dbInstance.database;
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
    final db = await MyFinDB.dbInstance.database;
    db.update(
      'stocks',
      stock.toMap(),
      where: "id = ?",
      whereArgs: [stock.id],
    );
  }

  Future<void> deleteStock(Stock stock) async {
    final db = await MyFinDB.dbInstance.database;
    db.delete(
      'stocks',
      where: "id = ?",
      whereArgs: [stock.id],
    );
  }

  Future<void> deleteStockById(int id) async {
    final db = await MyFinDB.dbInstance.database;
    db.delete(
      'stocks',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<double?> getTotalInvestments() async {
    final db = await MyFinDB.dbInstance.database;
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
  }

}