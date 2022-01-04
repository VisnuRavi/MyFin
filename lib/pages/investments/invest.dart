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
    ////print("id $id");
    //print("s~~~~~~");
    //print(s);
    Map<String, dynamic> map = await MyFinDB.dbInstance.readStockMap(1);
    //print("${map['id']}:${map['id'].runtimeType} ${map['name']}:${map['name'].runtimeType} ${map['brokerage']}:${map['brokerage'].runtimeType} ${map['bought_price']}:${map['bought_price'].runtimeType} ${map['bought_date']}.${map['bought_date'].runtimeType} ${map['brokerage']}:${map['brokerage'].runtimeType} ${map['lots']}:${map['lots'].runtimeType} ${map['sold_price']}:${map['sold_price'].runtimeType} ${map['sold_date']}:${map['sold_date'].runtimeType}");*/
    //Stock s1 = await MyFinDB.dbInstance.readStock(1);
    ////print("s1 $s1");
    //MyFinDB.dbInstance.deleteStockById(1);
    //int id = await MyFinDB.dbInstance.insertStock(s);//init state only gets called when the page is 1st loaded and thats it
    stocks = await MyFinDB.dbInstance.readAllStocks();
    /*for (int i = 1; i<=19; i++) {
      MyFinDB.dbInstance.deleteStockById(i);
    }*/

    /*for (int i=0; i<stocks.length; i++) {
      //print(stocks[i]);
    }*/
    setState(() {
      //stocks = await MyFinDB.dbInstance.readAllStocks(); //dont do async within setstate
      isLoading = false;
      //print("setting state");
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
              title: Row(children: [Flexible(child: Text("${stocks[index].name} (${stocks[index].symbol})"))]),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text("Bought: ${stocks[index].bought_price.toStringAsFixed(2)}")
                  ),
                  SizedBox(width: 10.0),
                  Flexible(child: displaySoldPrice(stocks[index])),
                  SizedBox(width:20.0),
                  Flexible(child: displayPercentage(stocks[index])),//this flex is overflowing
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

  Widget displaySoldPrice(Stock s) {
    if (s.sold_price == null) {
      return Text("Sold: -");
    } else {
      return Text("Sold: ${s.sold_price!.toStringAsFixed(2)}");
    }
  }

  Widget displayPercentage(Stock s) {
    if (s.sold_price == null) {
      return Text("-");
    } else {
      return s.percentageChange(s.sold_price!);
    }
  }

}