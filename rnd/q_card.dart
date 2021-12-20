// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'q.dart';

class qCard extends StatelessWidget {

  final q q4;
  Function removeQ;
  qCard({required this.q4, required this.removeQ});
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5.0),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
            Text("q1 ${q4.q1}"),
            SizedBox(height: 5.0,),
            Text("q2!! ${q4.q2}"),
            SizedBox(height: 5.0),
            TextButton.icon(
              onPressed: () {removeQ();},
              icon: Icon(Icons.delete),
              label: Text("del"),
              )
          ], 
        ),
      ),
    );
  }
}