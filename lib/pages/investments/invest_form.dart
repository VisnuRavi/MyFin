// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:myfin/form_question.dart';
import 'package:myfin/models/stock.dart';
import 'package:myfin/database/myfin_db.dart';

class InvestForm extends StatefulWidget {

  @override
  State<InvestForm> createState() => _InvestFormState();
}

class _InvestFormState extends State<InvestForm> {

  final _formKey = GlobalKey<FormState>();//reference to the Form
  String name = '';
  String symbol = '';
  double boughtPrice = 0;
  DateTime boughtDate = DateTime.now();
  String brokerage = '';
  double? soldPrice;
  DateTime? soldDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Investments Form"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            RequiredFormQuestion("Stock Name", 
              () => (value) { //have to make it such that the method can be called from the template, with the parameters needed, so have extra (), else need to also pass in value as a param i believe
                //setState(() {name = value;}); // not necessary to set state as not changing the view, not rebuilding widget i think
                name = value;
              } 
            ),
            RequiredFormQuestion("Stock Symbol",
              () => (value) => symbol = value
            ),
            RequiredFormQuestion("Bought Price",
              () => (value) => boughtPrice = double.parse(value)
            ),
            RequiredFormQuestion("Bought Date (YYYY-MM-DD)",
            () => (value) {
              boughtDate = DateTime.parse(value);
              }
            ),
            RequiredFormQuestion("Brokerage", 
            () => (value) => brokerage = value
            ),
            OptionalFormQuestion("Sold Price", 
              () => (value) {
                if (value == "") {
                  soldPrice = null;
                } else {
                  soldPrice = double.parse(value);
                }
              }
            ),
            OptionalFormQuestion("Sold Date (YYYY-MM-DD)", 
              () => (value) {
                if (value == "") {
                  soldDate = null;
                } else {
                  soldDate = DateTime.parse(value);
                }
              }
            ),
            ElevatedButton(
              onPressed: () {
                print('clicked');
                if (_formKey.currentState!.validate()) {
                  print("valid");
                  _formKey.currentState!.save();
                  /*print(name);
                  print(symbol);
                  print(boughtPrice);
                  print(boughtDate);
                  print(brokerage);
                  print(soldPrice);
                  print(soldDate);*/
                  /*Stock stock = Stock(name: name, symbol: symbol, bought_price: boughtPrice, bought_date: boughtDate, brokerage: brokerage, sold_price: soldPrice, sold_date: soldDate);
                  MyFinDB.dbInstance.insertStock(stock);*/
                } else {
                  print("invalid");
                }
              },
              child: Text("Submit")
            ),
          ],
        ),
      ),
    );
  }
}
