// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:myfin/form_question.dart';

class InvestForm extends StatefulWidget {

  @override
  State<InvestForm> createState() => _InvestFormState();
}

class _InvestFormState extends State<InvestForm> {

  final _formKey = GlobalKey<FormState>();

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
            RequiredFormQuestion("Stock Name"),
            RequiredFormQuestion("Stock Symbol"),
            RequiredFormQuestion("Bought Price"),
            RequiredFormQuestion("Bought Date"),
            RequiredFormQuestion("Brokerage"),
            OptionalFormQuestion("Sold Price"),
            OptionalFormQuestion("Sold Date"),
            ElevatedButton(
              onPressed: () {
                print('clicked');
                if (_formKey.currentState!.validate()) {
                  print("valid");
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
