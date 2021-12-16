class groceryProducts {
  
  String _productDetails;
  String _productTitle;
  String _productImage;
  double _productPrice;
  double _productWeight;
  int _productId;


  groceryProducts(this._productImage, this._productTitle, this._productDetails, this._productPrice, this._productWeight, this._productId) {}

  double get productWeight => _productWeight;

  double get productPrice => _productPrice;

  String get productTitle => _productTitle;

  String get productImage => _productImage;

  int get productId => _productId;

  String get productDetails => _productDetails;


}