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
  bool isLoadingStocks = true;
  //Stock s = Stock.zero();
  //bool isLoadingStockPrice = true;


  void initState() { //init state only gets called when the page is 1st loaded and thats it
    super.initState();
    refreshStocksList(); //does this async without waiting
  }

  void refreshStocksList() async {//create the async function by itself to only change the external state of the data you want to store, and the bool variable attached. then use this function inside another function
    //MyFinDB.dbInstance.deleteStockById(1);
    //int id = await MyFinDB.dbInstance.insertStock(s);//init state only gets called when the page is 1st loaded and thats it
    stocks = await MyFinDB.dbInstance.readAllStocks();

    setState(() {
      //stocks = await MyFinDB.dbInstance.readAllStocks(); //dont do async within setstate
      isLoadingStocks = false;
      });
  }

   Widget bodyLayout(List<Stock> stocks) {
    if (isLoadingStocks) {
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
              title: Row(children: [Flexible(child: Text("${stocks[index].name} (${stocks[index].symbol})"))]),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text("Bought: ${stocks[index].bought_price.toStringAsFixed(2)}")
                  ),
                  SizedBox(width: 10.0),
                  displaySoldOrCurrentPrice(stocks[index]),
                  SizedBox(width:20.0),
                  displayPercentage(stocks[index]),
                ],
              ),
              onTap: () async {
                await Navigator.pushNamed(context, '/invest_details', arguments: {
                  'stock' : stocks[index]
                });
                refreshStocksList();
              },
            ),
            //color: Colors.purple[50],
          );
        }
      );
    }
  }

  //try getting the curr price each time app open 1st, then work on getting it to build the widget each time. i think can set the isloadingcurrprice to false after setstate?

  void getStockCurrentPrice(Stock s) async {
    if (s.sold_price == null) {
      await s.getCurrPrice();
      setState(() {
        s.isLoadingCurrPrice = false;
      });
    }
  }

  Widget displaySoldOrCurrentPrice(Stock s) {
    getStockCurrentPrice(s);

    if (s.sold_price == null) {
      if (s.isLoadingCurrPrice) {
        return Text('Loading..');
      } else {
        if (s.currPrice == null) {
          return Text("Open: -");
        } else {
          return Text("Open: ${s.currPrice!.toStringAsFixed(2)}");
        }
      }
    } else {
      return Text("Sold: ${s.sold_price!.toStringAsFixed(2)}");
    }
  }

  Widget displayPercentage(Stock s) {
    return s.percentageChange();
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
        backgroundColor: Colors.purple,
      ),
      body: bodyLayout(stocks),
      //backgroundColor: Colors.purple[50],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //print('clicked investform');
          await Navigator.pushNamed(context, '/invest_form');
          refreshStocksList();//has setState in it
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.purple,
      ),
    );
  }
}