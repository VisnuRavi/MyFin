// ignore_for_file: prefer_const_constructors
import "package:flutter/material.dart";
import 'pages/home.dart';
import 'pages/invest.dart';
void main() => runApp(MyFin());

class MyFin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      routes: {
      '/': (context) => Home(),
      '/invest': (context) => Invest(),
      },
    );
  }
}
