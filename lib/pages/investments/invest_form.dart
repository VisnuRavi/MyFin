// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:myfin/form_question.dart';
import 'package:myfin/models/stock.dart';
import 'package:myfin/database/myfin_db.dart';

class InvestForm extends StatefulWidget {

  @override
  State<InvestForm> createState() => _InvestFormState();
}

class _InvestFormState extends State<InvestForm> {

  final _formKey = GlobalKey<FormState>();//reference to the Form
  String name = '';
  String symbol = '';
  double boughtPrice = 0;
  DateTime boughtDate = DateTime.now();
  String brokerage = '';
  int lots = 0;
  double? soldPrice;
  DateTime? soldDate;

  Stock? s;
  String? initName;
  String? initSym;
  String? initBoughtP;
  String? initBoughtD;
  String? initBrokerage;
  String? initLots;
  String? initSoldP;
  String? initSoldD;

  void updateInit() {
    if (s != null) {
      initName = s!.name;
      initSym = s!.symbol;
      initBoughtP = s!.bought_price.toString();
      initBoughtD = s!.bought_date.toIso8601String().substring(0,10);
      initBrokerage = s!.brokerage;
      initLots = s!.lots.toString();
      if (s!.sold_price != null) {
        initSoldP = s!.sold_price!.toString();
        initSoldD = s!.sold_date!.toIso8601String().substring(0,10);
      }
    }
  }

  Widget getTitle() {
    String title = "New Investment";
    if (s != null) {
      title = "Edit Investment";
    }
    return Text(
      title,
      style: TextStyle(
        fontSize: 25.0,
      ),
    );
  }

  bool isNullOrEmpty(value) {
    if (value == null || value.isEmpty) {
      return true;
    }
    return false;
  }

  String? nameValidator(value) {
    if (isNullOrEmpty(value)) {
      return 'Required';
    }//check if stock exist
    return null;
  }

  String? symbolValidator(value) {
    if (isNullOrEmpty(value)) {
      return 'Required';
    }//check if stock exist
    return null;
  }

  String? numValidator(value) {
    if (isNullOrEmpty(value)) {
      return 'Required';
    }
    dynamic number = num.tryParse(value);
    if (number == null) {
      return 'Enter a value';
    } else if (number >= 1000000) {
      return 'Enter a value less than 1000000';
    }
    return null;
  }

  String? optionalNumValidator(value) {
    if (!isNullOrEmpty(value)) {
      dynamic number = num.tryParse(value);
      if (number == null) {
        return 'Enter a value';
      }
      return null;
    }
    return null;
  }

  String? brokerageValidator(value) {  
    if (isNullOrEmpty(value)) {
      return 'Required';
    }
    return null;
  }

  String? dateValidator(value) {//need a better validator to check for valid month and day
    if (isNullOrEmpty(value)) {
      return 'Required';
    }
    DateTime? datetime = DateTime.tryParse(value);
    if (datetime == null || datetime.isAfter(DateTime.now())) {
      return "Enter a valid date in the correct format";
    }
    return null;
  }

  String? optionalDateValidator(value) {//need to validate that this date is after the bought date
    if (!isNullOrEmpty(value)) {
      DateTime? datetime = DateTime.tryParse(value);
      if (datetime == null || datetime.isAfter(DateTime.now())) {
        return "Enter a valid date in the correct format";
      }
      return null;
    }
    return null;
  }



  @override
  Widget build(BuildContext context) {
    dynamic map = ModalRoute.of(context)!.settings.arguments;
    if (map != null) {
      map = map as Map<String, Stock>;
      print("map not null");
      s = map['stock']!;
      updateInit();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Investments Form"),
        backgroundColor: Colors.purple,
      ),
      body: 
      Form(
        key: _formKey,
        //using listview will only render the fields that are visible, which can lead to old values going missing
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 15.0),
              Center(
                child: getTitle(),
              ),
              FormQuestion("Stock Name", 
                initName,
                () => (value) { //have to make it such that the method can be called from the template, with the parameters needed, so have extra (), else need to also pass in value as a param i believe
                  //setState(() {name = value;}); // not necessary to set state as not changing the view, not rebuilding widget i think
                  name = value;
                }, 
                () => (value) => nameValidator(value)
              ),
              FormQuestion("Stock Symbol",
                initSym,
                () => (value) => symbol = value,
                () => (value) => symbolValidator(value)
              ),
              FormQuestion("Bought Price",
                initBoughtP,
                () => (value) => boughtPrice = double.parse(double.parse(value).toStringAsFixed(2)),
                () => (value) => numValidator(value)
              ),
              FormQuestion("Bought Date (YYYY-MM-DD)",
                initBoughtD,
                () => (value) {boughtDate = DateTime.parse(value);},
                () => (value) => dateValidator(value)
              ),
              FormQuestion("Brokerage", 
                initBrokerage,
                () => (value) => brokerage = value,
                () => (value) => brokerageValidator(value)
              ),
              FormQuestion("Lots", 
                initLots,
                () => (value) => lots = int.parse(value),
                () => (value) => numValidator(value)
              ),
              FormQuestion("Sold Price (optional)", 
                initSoldP,
                () => (value) {
                   soldPrice = double.tryParse(value);
                   if (soldPrice != null) {
                     soldPrice = double.parse(soldPrice!.toStringAsFixed(2));
                   }
                },
                  /*if (value == "") {
                    soldPrice = null;
                  } else {
                    soldPrice = double.parse(value);
                  }
                },*/
                () => (value) => optionalNumValidator(value)
              ),
              FormQuestion("Sold Date (YYYY-MM-DD) (optional)",
                initSoldD, 
                () => (value) => soldDate = DateTime.tryParse(value),
                  /*if (value == "") {
                    soldDate = null;
                  } else {
                    soldDate = DateTime.parse(value);
                  }
                },*/
                () => (value) => optionalDateValidator(value)//need check to see if after bought date
              ),
              ElevatedButton(
                onPressed: () {
                  print('clicked');
                  if (_formKey.currentState!.validate()) {
                    print("valid");
                    _formKey.currentState!.save();

                    if (map == null) {
                      Stock newStock = Stock(symbol: symbol, name: name, bought_date: boughtDate, bought_price: boughtPrice, brokerage: brokerage, lots: lots, sold_price: soldPrice, sold_date: soldDate);
                      MyFinDB.dbInstance.insertStock(newStock);
                    } else {
                      print("in else to update");
                      print("soldp $soldPrice soldD $soldDate");
                      s!.updateStock(name, symbol, boughtPrice , boughtDate, brokerage, lots, soldPrice, soldDate);
                      MyFinDB.dbInstance.updateStock(s!);
                    }
                    /*print(name);
                    print(symbol);
                    print(boughtPrice);
                    print(boughtDate);
                    print(brokerage);
                    print(soldPrice);
                    print(soldDate);*/
                    /*Stock stock = Stock(name: name, symbol: symbol, bought_price: boughtPrice, bought_date: boughtDate, brokerage: brokerage, sold_price: soldPrice, sold_date: soldDate);
                    MyFinDB.dbInstance.insertStock(stock);*/
                    Navigator.pop(context);
                  } else {
                    print("invalid");
                  }
                },
                child: Text("Submit"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
