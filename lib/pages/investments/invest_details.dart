import 'package:flutter/material.dart';
import 'package:myfin/models/stock.dart';
import 'package:myfin/database/myfin_db.dart';

class InvestDetails extends StatefulWidget {  @override
  State<InvestDetails> createState() => _InvestDetailsState();
}

class _InvestDetailsState extends State<InvestDetails> {
  Stock stock = Stock.zero();

  void refreshStock() async {
    Stock editedStock = await MyFinDB.dbInstance.readStock(stock.id!);
    setState(() {
      print('edit');
      stock = editedStock;
      print("editedStock sold: ${editedStock.sold_price}");
      print("stock sold: ${stock.sold_price}");
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Stock> map = ModalRoute.of(context)!.settings.arguments as Map<String, Stock>;//typecast
    stock = map['stock']!;//the Stock can be null in the map

    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
        child: Column(
          children: [
            Text(
              "${stock.name} (${stock.symbol})",
              style: TextStyle(fontSize: 30.0),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Text("Bought Date: ${stock.bought_date.day.toString()}/${stock.bought_date.month.toString()}/${stock.bought_date.year.toString()}"),
                SizedBox(width:20.0),
                Text("Bought: ${stock.bought_price.toString()}"),
              ],
            ),
            SizedBox(height:10.0),
            displayPercentage(stock),
            SizedBox(height: 10.0,),
            displaySold(stock),
            SizedBox(height:10.0),
            Row(
              children: [
                Text("Brokerage: ${stock.brokerage}"),
                SizedBox(width: 10.0),
                Text("Lots: ${stock.lots.toString()}")
              ],
            ),
            Expanded(//expands to take the rest of the area
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: <Widget> [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          await Navigator.pushNamed(context, "/invest_form", arguments: {'stock':stock});
                          refreshStock();
                        },
                        child: Text("Edit"),
                      ),
                    ),
                    SizedBox(width:10.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          MyFinDB.dbInstance.deleteStock(stock);
                          Navigator.pop(context);
                        },
                        child: Text("Delete"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Text("sdf"),
          ],
        ),
      ),
    );
  }

    Widget displaySold(Stock s) {
    if (s.sold_price == null) {
      return Row(
        children: [
          Text("Sold Date: -"),
          SizedBox(width:118.0),
          Text("Sold: -"),
        ],
      );
    } else {
      return Row(
        children: [
          Text("Sold Date: ${stock.sold_date!.day.toString()}/${stock.sold_date!.month.toString()}/${stock.sold_date!.year.toString()}"),
          SizedBox(width:38.0),
          Text("Sold: ${stock.sold_price.toString()}"),
        ],
      );
    }
  }

  Widget displayPercentage(Stock s) {
    if (s.sold_price == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(50.0, 0, 0, 0),//why so diff from below??
        child: Text("-"),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(188.0, 0, 0, 0),
        child: s.percentageChange(s.sold_price!),
      );
    }
  }
}