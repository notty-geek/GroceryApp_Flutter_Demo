

class Product {

  String _urlToImage;
  String _about;
  String _title;
  double _price;
  double _weight;
  int _id;
  bool canBeDelivered;
  String _category;

  Map<String, dynamic> toJson() =>
      {
        'images': _urlToImage,
        'name': _title,
        'about':_about,
        'rank':_id,
        'price':_price,
        'quantity':_weight,
        'category':_category
      };


  Product(this._urlToImage, this._title, this._price, this._weight, this._id, this.canBeDelivered, this._about,this._category);

  double get weight => _weight;

  double get price => _price;


  set price(double price) => this._price = price;

  String get title => _title;

  String get urlToImage => "assets/images/$_urlToImage";

  int get id => _id;

  String get about => _about;

  set about(String about) => this._about = about;

}