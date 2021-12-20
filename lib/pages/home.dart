// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            SafeArea(
              child: Text(
                'Net Worth',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
                ),
            ),
            SizedBox(height: 30.0),
            Text(
              'Investments',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 200.0),
            Row(
              children: <Widget>[
                OutlinedButton(
                  onPressed: () {
                    print('clicked invest');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical:20.0, horizontal:0.0),
                    child: Text(
                      'Invest',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      
    );
  }
}