import 'package:flutter/material.dart';
import 'package:myfin/models/stock.dart';
import 'package:myfin/database/stock_db.dart';
import 'package:intl/intl.dart';

class InvestDetails extends StatefulWidget {  @override
  State<InvestDetails> createState() => _InvestDetailsState();
}

class _InvestDetailsState extends State<InvestDetails> {
  Stock stock = Stock.zero();
  final dateFormat = DateFormat("dd/MM/yyyy");

  void refreshStock() async {
    Stock editedStock = await StockDB.stockFns.readStock(stock.id!);
    setState(() {
      //print('edit');
      stock = editedStock;
      //print("editedStock sold: ${editedStock.sold_price}");
      //print("stock sold: ${stock.sold_price}");
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Stock> map = ModalRoute.of(context)!.settings.arguments as Map<String, Stock>;//typecast
    stock = map['stock']!;//the Stock can be null in the map

    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "${stock.name} (${stock.symbol})",
                style: TextStyle(fontSize: 30.0),
              ),
            ),
            Divider(
              height: 40.0, color: Colors.purple[200],
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Text("Bought Date: ${dateFormat.format(stock.bought_date)}"),
                SizedBox(width:20.0),
                Text("Bought: ${stock.bought_price.toStringAsFixed(2)}"),
              ],
            ),
            SizedBox(height:10.0),
            displayPercentage(stock),//still overflowing with flexible(flexible affects expanded button position though)
            SizedBox(height: 10.0,),
            displaySoldOrCurrent(stock),//still overflowing with flexible
            SizedBox(height:30.0),
            Text("Brokerage: ${stock.brokerage}"),
            SizedBox(height: 30.0),
            Text("Shares: ${stock.shares.toString()}"),
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
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                        ),
                      ),
                    ),
                    SizedBox(width:10.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          StockDB.stockFns.deleteStock(stock);
                          Navigator.pop(context);
                        },
                        child: Text("Delete"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                        ),
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

    //will need to edit these 2 fn below
    Widget displaySoldOrCurrent(Stock s) {
    if (s.sold_price == null && s.currPrice == null) {
      return Row(
        children: [
          Text("Sold Date: -"),
          SizedBox(width:117.0),
          Text("Sold: -"),
        ],
      );
    } else if (s.currPrice != null) {
      return Row(
        children: [
          Text("Sold Date: -"),
          SizedBox(width:118.0),
          Text("Open: ${stock.currPrice!.toStringAsFixed(2)}"),
        ],
      );
    } else {
      return Row(
        children: [
          Text("Sold Date: ${dateFormat.format(stock.sold_date!)}"),
          SizedBox(width:38.0),
          Text("Sold: ${stock.sold_price!.toStringAsFixed(2)}"),
        ],
      );
    }
  }

  Widget displayPercentage(Stock s) {
    if (s.sold_price == null && s.currPrice == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(197.0, 0, 0, 0),//why so diff from below??
        child: Text("-"),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(189.0, 0, 0, 0),
        child: s.percentageChange(),
      );
    }
  }
}