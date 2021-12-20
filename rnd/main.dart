// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'q.dart';
import 'q_card.dart';

void main() =>  runApp(MaterialApp(
  home: HomePage(),
));



class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int num = 0;
  List<q> q3 = [q(q1:"sdf", q2:"sdf"), q(q1:"df", q2:"df"), q(q1:"dswr", q2:"dswr"), q(q1:"sdf", q2:"sdf"), q(q1:"sdf", q2:"sdf"), q(q1:"sdf", q2:"sdf"), q(q1:"sdf", q2:"sdf"), q(q1:"sdf", q2:"sdf"), q(q1:"sdf", q2:"sdf"), q(q1:"sdf", q2:"sdf")];

  Widget qformat(q q) {
    return qCard(
      q4: q,
      removeQ: (
        () {
          setState(() {
            remQ(q);//creates the delete fn for the qCard
          });
        }
      ),
    );
  }

  void remQ(q q) {
    q3.remove(q);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hey now"),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: q3.map((x) {
          return qformat(x);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("$num"),
        onPressed: () {
          setState(() {
            num += 1;
          });
        },
      ),
    );
  }
}

