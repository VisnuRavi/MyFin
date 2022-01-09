import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';  

class Stock {
  int? id;
  String name = 'eg';
  String symbol = 'eg';
  double bought_price = 0.0;
  DateTime bought_date = DateTime.parse('2021-12-12');
  String brokerage = 'eg';
  int shares = 0;
  double? sold_price = 0.0;
  DateTime? sold_date = DateTime.parse('2021-12-12');//can look to use DateFormat

  //bool isLoadingCurrPrice = true;//initially used in invest.dart to get the curr price when building the ListTile
  double? currPrice;

  Stock({this.id, required this.name, required this.symbol, required this.bought_price,required this.bought_date, required this.brokerage, required this.shares, this.sold_price, this.sold_date});

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
      'lots': shares,
      'sold_price': sold_price,
      'sold_date': isoSoldDate,
    };
  } 

  static Stock fromDB(Map<String, dynamic> map) { 
    //i think cant use named constructor coz possible to put in null to the non nullables. just use method and put inside
    //use async to get the currprice
    DateTime? mapSoldDate = null;
    if (map['sold_date'] != null) {
      mapSoldDate = DateTime.parse(map['sold_date'] as String);
    }
    Stock currentStock = Stock(
      id: map['id'] as int,
      name: map['name'] as String,
      symbol: map['symbol'] as String,
      brokerage: map['brokerage'] as String,
      bought_price: map['bought_price'] as double,
      bought_date: DateTime.parse(map['bought_date'] as String),
      shares: map['lots'],
      sold_price: map['sold_price'] as double?,
      sold_date: mapSoldDate,//must always handle the null values!!
    );
    /*if (currentStock.sold_price == null) {
      await currentStock.getCurrPrice();
    }*/

    return currentStock;
  }

  void setId(int id) {
    this.id = id;
  }

  Widget percentageChange() {
    double? priceToUse;
    if (sold_price != null) {
      priceToUse = sold_price;
    } else if (currPrice != null) {
      priceToUse = currPrice;
    }

    if (priceToUse == null) {
      return Text("-");
    }

    double change = double.parse((((priceToUse - bought_price)/bought_price) * 100).toStringAsFixed(2));
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

  void updateStock(String editedName, String editedSymbol, double editedBought_price, DateTime editedBought_date, String editedBrokerage, int editedShares, double? editedSold_price, DateTime? editedSold_date) {
    this.name = editedName;
    this.symbol = editedSymbol;
    this.bought_price = editedBought_price;
    this.bought_date = editedBought_date;
    this.brokerage = editedBrokerage;
    this.shares = editedShares;
    this.sold_price = editedSold_price;
    this.sold_date = editedSold_date;
  }

  Future<void> getCurrPrice() async {//shld only be called if sold_price=null
    try {
      print("!!!!!!!getcurr");
      String apiKey = 'NNYYWKK428VQMEXM';
      String url = "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$apiKey";

      Response response = await get(Uri.parse(url));//need on wifi
      print(response.body);
      Map globalQuoteMap = json.decode(response.body);
      if (globalQuoteMap['Global Quote'] != null) {
        print("~~~~~~~$globalQuoteMap");
        String? openPrice = globalQuoteMap['Global Quote']!['02. open'];
        print("~~~~~~~~$openPrice");
        if (openPrice != null) {
          currPrice = double.parse(openPrice);
        } else {
          currPrice = null;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  String toString() {
    return "Stock{id: $id, stock name: $name, stock id: $symbol, brokerage: $brokerage, bought price: $bought_price, bought date: $bought_date, shares: $shares, sold price: $sold_price, sold date: $sold_date}";
  }
}