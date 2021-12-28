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
  double? sold_price;
  DateTime? sold_date;

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
    return Stock(
      id: map['id'] as int,
      name: map['name'] as String,
      symbol: map['symbol'] as String,
      brokerage: map['brokerage'] as String,
      bought_price: map['bought_price'] as double,
      bought_date: map['bought_date'] as DateTime,
      lots: map['lots'],
      sold_price: map['sold_price'] as double,
      sold_date: map['sold_date'] as DateTime,
    );
  }

  void setId(int id) {
    this.id = id;
  }

  Widget percentageChange(double price) {
    double change = ((price - bought_price)/bought_price) * 100;
    if (change >= 0) {
      return Text(
        "+${change.toString()}%",
        style: TextStyle(
          color: Colors.green
        ),
      );
    } else {
      return Text(
        "${change.toString()}%",
        style: TextStyle(
          color: Colors.red
        ),
      );
    }
  } 

  @override
  String toString() {
    return "Stock{id: $id, stock name: $name, stock id: $symbol, brokerage: $brokerage, bought price: $bought_price, bought date: $bought_date, lots: $lots, sold price: $sold_price, sold date: $sold_date}";
  }
}