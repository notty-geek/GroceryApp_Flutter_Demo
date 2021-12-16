import 'package:grocerry_app/model/orderModel.dart';
class GroceryCart{

  late List<productOrder> _cartOrders;

  void addCartOrder(productOrder order){
    _cartOrders.add(order);
  }

  void removeCartOrder(productOrder order){
    _cartOrders.remove(order);
  }

  double getTotalPrice(){
    double totalPrice = 0;
    _cartOrders.forEach((i){
      totalPrice += i.orderPrice;
    });

    return totalPrice;
  }

  List<productOrder> get cartOrders => _cartOrders;

  int get cartOrderCount => _cartOrders.length;

  bool get cartIsEmpty => _cartOrders.length == 0;

}