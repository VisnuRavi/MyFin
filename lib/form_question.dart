import "package:flutter/material.dart";

class RequiredFormQuestion extends StatelessWidget {

  String label = "";
  Function saveFunction = () => print("uninitialised");
  
  RequiredFormQuestion(String label, Function saveFunction) {
    this.label = label;
    this.saveFunction = saveFunction;
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
        onSaved: saveFunction(),
      ),
    );
  }
}

class OptionalFormQuestion extends  StatelessWidget {
  
  String label = "";
  Function saveFunction = () => print("uninitialised");
  
  OptionalFormQuestion(String label, Function saveFunction) {
    this.label = label;
    this.saveFunction = saveFunction;
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
        onSaved: saveFunction(),
      )
    );
  }
}