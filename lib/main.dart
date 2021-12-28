// ignore_for_file: prefer_const_constructors
import "package:flutter/material.dart";
import 'package:myfin/pages/home.dart';
import 'package:myfin/pages/investments/invest.dart';
import 'package:myfin/pages/investments/invest_form.dart';
import 'package:myfin/pages/investments/invest_details.dart';
void main() => runApp(MyFin());

class MyFin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: Home(),
      routes: {
      '/': (context) => Home(),
      '/invest': (context) => Invest(),
      '/invest_form': (context) => InvestForm(),
      '/invest_details': (context) => InvestDetails(),//use the arguments to pass in data
      },
    );
  }
}
