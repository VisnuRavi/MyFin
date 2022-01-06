// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:myfin/database/myfin_db.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  String totalInvestments = "None";

  getTotalInvestments() async {
    double? investmentValue =  await MyFinDB.dbInstance.getTotalInvestments();
    if (investmentValue != null) {
      totalInvestments = investmentValue.toStringAsFixed(2);
    }
    setState(() {
      isLoading = false;
    });
  }

  //method
  Widget displayInvestments() {
    String display = "";
    if (isLoading) {
      display = "Loading..";
    } else {
      display = "\$$totalInvestments";
    }

    return Text(
      display,
      style: TextStyle(fontSize: 20.0),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotalInvestments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.purple, Colors.white],
            stops: [0.2, 0.8],
          ),
        ),
        padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                child: Center(
                  child: Text(
                    'Net Worth',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                ),
              ),
            ),
            Divider(height: 40, color: Colors.black),
            SizedBox(height: 30.0),
            Row(
              children: [
                Text(
                  'Invested:',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(width:10.0),
                displayInvestments(),
              ],
            ),
            SizedBox(height: 250.0),
            Center(//wrapped with center for the time being, shld wrap with row
              child: OutlinedButton(
                onPressed: () async {
                  //print('clicked invest');
                  await Navigator.pushNamed(context, '/invest');
                  getTotalInvestments();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:20.0, horizontal:0.0),
                  child: Text(
                    'Invest',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}