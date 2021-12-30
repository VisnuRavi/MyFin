// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:myfin/models/stock.dart';
import 'package:myfin/database/myfin_db.dart';

class Invest extends StatefulWidget {
  @override
  State<Invest> createState() => _InvestState();
}

class _InvestState extends State<Invest> {
  List<Stock> stocks1 = [
    Stock(name: 'nam1', symbol: 'sym', bought_price: 2.0, bought_date: DateTime(2021, 12, 23), brokerage: 'brok', lots: 1000, sold_price: 3.0, sold_date: DateTime(2021, 12, 27)),
    Stock(name: 'nam2', symbol: 'sym', bought_price: 2.0, bought_date: DateTime(2021, 12, 23), brokerage: 'brok', lots: 1000, sold_price: 3.0, sold_date: DateTime(2021, 12, 27)),
    Stock(name: 'nam3', symbol: 'sym', bought_price: 2.0, bought_date: DateTime(2021, 12, 23), brokerage: 'brok', lots: 1000, sold_price: 3.0, sold_date: DateTime(2021, 12, 27)),
    Stock(name: 'nam4', symbol: 'sym', bought_price: 2.0, bought_date: DateTime(2021, 12, 23), brokerage: 'brok', lots: 1000, sold_price: 3.0, sold_date: DateTime(2021, 12, 27)),
    Stock(name: 'nam5', symbol: 'sym', bought_price: 2.0, bought_date: DateTime(2021, 12, 23), brokerage: 'brok', lots: 1000, sold_price: 3.0, sold_date: DateTime(2021, 12, 27)),
    Stock(name: 'nam6', symbol: 'sym', bought_price: 2.0, bought_date: DateTime(2021, 12, 23), brokerage: 'brok', lots: 1000, sold_price: 3.0, sold_date: DateTime(2021, 12, 27)),
    Stock(name: 'nam7', symbol: 'sym', bought_price: 2.0, bought_date: DateTime(2021, 12, 23), brokerage: 'brok', lots: 1000, sold_price: 3.0, sold_date: DateTime(2021, 12, 27)),
    Stock(name: 'nam8', symbol: 'sym', bought_price: 2.0, bought_date: DateTime(2021, 12, 23), brokerage: 'brok', lots: 1000, sold_price: 3.0, sold_date: DateTime(2021, 12, 27)),
    Stock(name: 'nam9', symbol: 'sym', bought_price: 2.0, bought_date: DateTime(2021, 12, 23), brokerage: 'brok', lots: 1000, sold_price: 1.0, sold_date: DateTime(2021, 12, 27)),
  ];

  List<Stock> stocks = [];
  bool isLoading = true;

  void initState() { //init state only gets called when the page is 1st loaded and thats it
    super.initState();
    refreshStocksList(); //does this async without waiting

  }

  Stock s = Stock.zero();
  void refreshStocksList() async {
    /*for (int i = 0; i < stocks1.length; i++) {
      await MyFinDB.dbInstance.insertStock(stocks1[i]); //need to wait for each to be added 1st
    }
    //int id = await MyFinDB.dbInstance.insertStock(s);
    //print("id $id");
    print("s~~~~~~");
    print(s);
    Map<String, dynamic> map = await MyFinDB.dbInstance.readStockMap(1);
    print("${map['id']}:${map['id'].runtimeType} ${map['name']}:${map['name'].runtimeType} ${map['brokerage']}:${map['brokerage'].runtimeType} ${map['bought_price']}:${map['bought_price'].runtimeType} ${map['bought_date']}.${map['bought_date'].runtimeType} ${map['brokerage']}:${map['brokerage'].runtimeType} ${map['lots']}:${map['lots'].runtimeType} ${map['sold_price']}:${map['sold_price'].runtimeType} ${map['sold_date']}:${map['sold_date'].runtimeType}");*/
    //Stock s1 = await MyFinDB.dbInstance.readStock(1);
    //print("s1 $s1");
    //MyFinDB.dbInstance.deleteStockById(1);
    //int id = await MyFinDB.dbInstance.insertStock(s);//init state only gets called when the page is 1st loaded and thats it
    stocks = await MyFinDB.dbInstance.readAllStocks();
    /*for (int i = 1; i<=19; i++) {
      MyFinDB.dbInstance.deleteStockById(i);
    }*/
    setState(() {
      //stocks = await MyFinDB.dbInstance.readAllStocks(); //dont do async within setstate
      isLoading = false;
      print("setting state");
      });
  }

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
      body: bodyLayout(stocks),
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

  Widget bodyLayout(List<Stock> stocks) {
    if (isLoading) {
      return Center(
        child: Text(
          'Loading...',
          style: TextStyle(
            color: Colors.grey[400],
          ),
        ),
      );
    }
    if (stocks.length == 0) {
      return Center(
        child: Text(
          'No investments added yet',
          style: TextStyle(
            color: Colors.grey[400],
          ),
        ),
      );
    } else {
      return ListView.builder(
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
                    SizedBox(width:20.0),
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
        );
    }
  }
}