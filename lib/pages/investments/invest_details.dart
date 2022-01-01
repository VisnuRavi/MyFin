import 'package:flutter/material.dart';
import 'package:myfin/models/stock.dart';

class InvestDetails extends StatelessWidget {//stateless 1st then add the edit and delete function
  Stock stock = Stock.zero();

  @override
  Widget build(BuildContext context) {
    Map<String, Stock> map = ModalRoute.of(context)!.settings.arguments as Map<String, Stock>;//typecast
    stock = map['stock']!;//the Stock can be null in the map

    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
        child: Column(
          children: [
            Text(
              "${stock.name} (${stock.symbol})",
              style: TextStyle(fontSize: 35.0),
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