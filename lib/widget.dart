import 'package:flutter/material.dart';
import 'package:grocerry_app/model/orderModel.dart';

class ProductOrderWidget extends StatelessWidget {
  final productOrder _order;
  final double _gridSize;
  ProductOrderWidget(this._order, this._gridSize);

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipOval(
              child: Container(
                  color: Colors.grey,
                  child: new Image.asset(this._order.product.productImage),
                  height:
                  (MediaQuery.of(context).size.height - _gridSize) * 0.5)),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: new Text(this._order.quantity.toString(),
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold))),
          const Text("X",
              style:
              TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          Flexible(
              flex: 2,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(this._order.product.productTitle,
                      style: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold)))),
          Flexible(
              flex: 1,
              child: Text("\$${this._order.orderPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold)))
        ]);
  }
}