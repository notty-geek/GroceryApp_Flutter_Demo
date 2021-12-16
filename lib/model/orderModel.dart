import 'package:groceryapptesting/model/productModel.dart';

class productOrder {

  groceryProducts _product;
  int _productQuantity;
  int _productId;

  productOrder(this._product, this._productQuantity, this._productId);

  int get id => _productId;

  int get quantity => _productQuantity;

  groceryProducts get product => _product;

  double get orderPrice => _productQuantity*_product.productPrice;

}