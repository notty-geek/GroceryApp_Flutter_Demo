import 'package:groceryapptesting/models/GroceryProduct.dart';

class Order {

  Product _product;
  int _quantity;
  int _id;

  Map<String, dynamic> toJson() =>
      {
        'order': Order(this._product, this._quantity, this._id),
        'product': product,
        'id':_id,
        'quantity':_quantity,
        'orderPrice':orderPrice
      };

  Order(this._product, this._quantity, this._id);

  int get id => _id;

  int get quantity => _quantity;

  Product get product => _product;

  double get orderPrice => _quantity*_product.price;

}