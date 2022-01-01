import "package:flutter/material.dart";

class FormQuestion extends StatelessWidget {

  String label = "";
  Function saveFunction = () => print("uninitialised");
  Function validatorFn = () => print("uninitialised validator");
  String? initVal;
  
  FormQuestion(String label, String? initVal, Function saveFunction, Function validatorFn) {
    this.label = label;
    this.saveFunction = saveFunction;
    this.validatorFn = validatorFn;
    this.initVal = initVal;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: TextFormField(
        initialValue: initVal,
        decoration: InputDecoration(
          labelText: label,
          border: UnderlineInputBorder(),
        ),
        validator: validatorFn(),
        onSaved: saveFunction(),
      ),
    );
  }
}
/*
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
}*/