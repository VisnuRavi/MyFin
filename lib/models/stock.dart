class Stock {
  int? id;
  String name;
  String symbol;
  double bought_price;
  DateTime bought_date;
  String brokerage;
  double? sold_price;
  DateTime? sold_date;

  Stock({required this.id, required this.name, required this.symbol, required this.bought_price,required this.bought_date, required this.brokerage, this.sold_price, this.sold_date});

  Map<String, dynamic> toMap() {
    String? isoSoldDate = null;
    if (sold_date != null) {
      isoSoldDate = sold_date!.toIso8601String();//add the ! to assert that it wouldnt be null here
    }
    return {
      'id': id,
      'name': name,
      'symbol': symbol,
      'bought_price': bought_price,
      'bought_date': bought_date.toIso8601String(),//convert for easier storage in sqlite
      'brokerage': brokerage,
      'sold_price': sold_price,
      'sold_date': isoSoldDate,
    };
  } 

  static Stock fromDB(Map<String, dynamic> map) { //i think cant use named constructor coz possible to put in null to the non nullables. just use method and put inside
    return Stock(
      id: map['id'] as int,
      name: map['name'] as String,
      symbol: map['symbol'] as String,
      brokerage: map['brokerage'] as String,
      bought_price: map['bought_price'] as double,
      bought_date: map['bought_date'] as DateTime,
      sold_price: map['sold_price'] as double,
      sold_date: map['sold_date'] as DateTime,
    );
  }

  void setId(int id) {
    this.id = id;
  }

  @override
  String toString() {
    return "Stock{id: $id, stock name: $name, stock id: $symbol, brokerage: $brokerage, bought price: $bought_price, bought date: $bought_date, sold price: $sold_price, sold date: $sold_date}";
  }
}