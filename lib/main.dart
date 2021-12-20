// ignore_for_file: prefer_const_constructors
import "package:flutter/material.dart";
import 'pages/home.dart';
import 'pages/invest.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/': (context) => Home(),
    '/invest': (context) => Invest(),
  },
));