class Stock {
  int id;
  String stock_name;
  String stock_id;
  double bought_price;
  DateTime bought_date;
  String brokerage;
  double? sold_price;
  DateTime? sold_date;

  Stock({required this.id, required this.stock_name, required this.stock_id, required this.bought_price,required this.bought_date, required this.brokerage, this.sold_price, this.sold_date});

  Map<String, dynamic> toMap() {
    String? isoSoldDate = null;
    if (sold_date != null) {
      isoSoldDate = sold_date!.toIso8601String();//add the ! to assert that it wouldnt be null here
    }
    return {
      'id': id,
      'stock_name': stock_name,
      'stock_id': stock_id,
      'bought_price': bought_price,
      'bought_date': bought_date.toIso8601String(),//convert for easier storage in sqlite
      'brokerage': brokerage,
      'sold_price': sold_price,
      'sold_date': isoSoldDate,
    };
  } 

  /*Stock.fromDB(Map<String, dynamic> map) { //i think cant coz possible to put in null to the non nullables
    this.id = map['id'];
    this.stock_name = map['stock_name'];
    this.stock_id = map['stock_id'];
    this.brokerage = map['brokerage'];
    this.bought_price = map['bought_price'];
    this.bought_date = map['bought_date'];
    this.sold_price = map['sold_price'];
    this.sold_date = map['sold_date'];
  }*/

  @override
  String toString() {
    return "Stock{id: $id, stock name: $stock_name, stock id: $stock_id, brokerage: $brokerage, bought price: $bought_price, bought date: $bought_date, sold price: $sold_price, sold date: $sold_date}";
  }
}