// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:myfin/models/stock.dart';

class Invest extends StatelessWidget {

  List<Stock> stocks = [
    Stock(id: 1, name: 'nam1', symbol: 'sym', bought_price: 2.0, bought_date: DateTime(2021, 12, 23), brokerage: 'brok', lots: 1000, sold_price: 3.0, sold_date: DateTime(2021, 12, 27)),
    Stock(id: 1, name: 'nam2', symbol: 'sym', bought_price: 2.0, bought_date: DateTime(2021, 12, 23), brokerage: 'brok', lots: 1000, sold_price: 3.0, sold_date: DateTime(2021, 12, 27)),
    Stock(id: 1, name: 'nam3', symbol: 'sym', bought_price: 2.0, bought_date: DateTime(2021, 12, 23), brokerage: 'brok', lots: 1000, sold_price: 3.0, sold_date: DateTime(2021, 12, 27)),
    Stock(id: 1, name: 'nam4', symbol: 'sym', bought_price: 2.0, bought_date: DateTime(2021, 12, 23), brokerage: 'brok', lots: 1000, sold_price: 3.0, sold_date: DateTime(2021, 12, 27)),
    Stock(id: 1, name: 'nam5', symbol: 'sym', bought_price: 2.0, bought_date: DateTime(2021, 12, 23), brokerage: 'brok', lots: 1000, sold_price: 3.0, sold_date: DateTime(2021, 12, 27)),
    Stock(id: 1, name: 'nam6', symbol: 'sym', bought_price: 2.0, bought_date: DateTime(2021, 12, 23), brokerage: 'brok', lots: 1000, sold_price: 3.0, sold_date: DateTime(2021, 12, 27)),
    Stock(id: 1, name: 'nam7', symbol: 'sym', bought_price: 2.0, bought_date: DateTime(2021, 12, 23), brokerage: 'brok', lots: 1000, sold_price: 3.0, sold_date: DateTime(2021, 12, 27)),
    Stock(id: 1, name: 'nam8', symbol: 'sym', bought_price: 2.0, bought_date: DateTime(2021, 12, 23), brokerage: 'brok', lots: 1000, sold_price: 3.0, sold_date: DateTime(2021, 12, 27)),
    Stock(id: 1, name: 'nam9', symbol: 'sym', bought_price: 2.0, bought_date: DateTime(2021, 12, 23), brokerage: 'brok', lots: 1000, sold_price: 1.0, sold_date: DateTime(2021, 12, 27)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Investments',
          style: TextStyle(
          fontSize: 20.0,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: stocks.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text("${stocks[index].name} (${stocks[index].symbol})"),
              subtitle: Row(
                children: [
                  Text("Bought: ${stocks[index].bought_price.toString()}"),
                  SizedBox(width: 10.0),
                  Text("Sold: ${stocks[index].sold_price.toString()}"),
                  SizedBox(width:10.0),
                  stocks[index].percentageChange(stocks[index].sold_price!),
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, '/invest_details', arguments: {
                  'stock' : stocks[index]
                });
              },
            )
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('clicked investform');
          Navigator.pushNamed(context, '/invest_form');
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}