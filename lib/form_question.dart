import "package:flutter/material.dart";

class RequiredFormQuestion extends StatelessWidget {

  String label = "";
  
  RequiredFormQuestion(String label) {
    this.label = label;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: UnderlineInputBorder(),
        ),
        validator: (value) {//try to combine the 2 classes, the null for Function instance is causing probs..
          if (value == null || value.isEmpty) {
            return 'Required';
          } 
          return null;
        },
      ),
    );
  }
}

class OptionalFormQuestion extends  StatelessWidget {
  
  String label = "";
  
  OptionalFormQuestion(String label) {
    this.label = label;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: UnderlineInputBorder(),
        ),
      )
    );
  }
}