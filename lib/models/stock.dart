import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Stock {
  int? id;
  String name = 'eg';
  String symbol = 'eg';
  double bought_price = 0.0;
  DateTime bought_date = DateTime.parse('2021-12-12');
  String brokerage = 'eg';
  int lots = 0;
  double? sold_price = 0.0;
  DateTime? sold_date = DateTime.parse('2021-12-12');//can look to use DateFormat

  Stock({this.id, required this.name, required this.symbol, required this.bought_price,required this.bought_date, required this.brokerage, required this.lots, this.sold_price, this.sold_date});

  Stock.zero();

  Map<String, dynamic> toMap() {
    String? isoSoldDate = null;
    if (sold_date != null) {
      isoSoldDate = sold_date!.toIso8601String();//add the ! to assert that it wouldnt be null here
    }
    return {
      'id': id,
      'name': name,
      'symbol': symbol,
      'bought_price': bought_price,
      'bought_date': bought_date.toIso8601String(),//convert for easier storage in sqlite
      'brokerage': brokerage,
      'lots': lots,
      'sold_price': sold_price,
      'sold_date': isoSoldDate,
    };
  } 

  static Stock fromDB(Map<String, dynamic> map) { //i think cant use named constructor coz possible to put in null to the non nullables. just use method and put inside
    DateTime? mapSoldDate = null;
    if (map['sold_date'] != null) {
      mapSoldDate = DateTime.parse(map['sold_date'] as String);
    }
    return Stock(
      id: map['id'] as int,
      name: map['name'] as String,
      symbol: map['symbol'] as String,
      brokerage: map['brokerage'] as String,
      bought_price: map['bought_price'] as double,
      bought_date: DateTime.parse(map['bought_date'] as String),
      lots: map['lots'],
      sold_price: map['sold_price'] as double?,
      sold_date: mapSoldDate,//must always handle the null values!!
    );
  }

  void setId(int id) {
    this.id = id;
  }

  Widget percentageChange(double price) {
    double change = double.parse((((price - bought_price)/bought_price) * 100).toStringAsFixed(2));
    if (change >= 0) {
      return Row(
        children: [
          Icon(
            Icons.arrow_drop_up,
            color: Colors.green,
          ),
          Text(
            "${change.toString()}%",
            style: TextStyle(
              color: Colors.green
            ),
          ),
        ],
      );
    } else {
      change = change.abs();
      return Row(
        children: [
          Icon(
            Icons.arrow_drop_down,
            color: Colors.red,
          ),
          Text(
            "${change.toString()}%",
            style: TextStyle(
              color: Colors.red
            ),
          ),
        ],
      );
    }
  } 

  @override
  String toString() {
    return "Stock{id: $id, stock name: $name, stock id: $symbol, brokerage: $brokerage, bought price: $bought_price, bought date: $bought_date, lots: $lots, sold price: $sold_price, sold date: $sold_date}";
  }
}