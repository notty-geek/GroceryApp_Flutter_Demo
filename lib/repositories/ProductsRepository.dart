import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groceryapptesting/models/GroceryProduct.dart';

class ProductsRepository {
  Future update_data(product_data) async {
    var product_json = product_data.toJson();
    print(product_json);

    var getcollection = FirebaseFirestore.instance.collection('products');
    var product = await getcollection.doc('cRG7tk2mj68VHTQv1BGH').get();
    Map<String, dynamic> data = product.data();
    var products = data["products"];
    for (var i = 0; i < products.length; i++) {
      if (products[i]['rank'] == product_data.id) {
        products[i] = product_json;
      }
    }

    getcollection.doc('cRG7tk2mj68VHTQv1BGH').update({"products": products});
    return true;
  }

  Future get_data(filter_type, category) async {
    print(filter_type);
    print(category);
    final List<Product> loadedList = [];
    var collection = FirebaseFirestore.instance.collection('products');
    var product = await collection.doc('cRG7tk2mj68VHTQv1BGH').get();
    Map<String, dynamic> data = product.data();
    var products = data["products"];
    print(products);
    print(products.length);

    for (var i = 0; i < products.length; i++) {
      print(i);
      print(products[i]);
      if (filter_type == "price") {
        print("In price");
        loadedList.add(new Product(
            products[i]['images'],
            products[i]['name'],
            products[i]['price'].toDouble(),
            products[i]['quantity'].toDouble(),
            products[i]['rank'],
            false,
            products[i]['about'],
            products[i]['category']));
      } else if (products[i]['category'] == category &&
          filter_type == "category") {
        loadedList.add(new Product(
            products[i]['images'],
            products[i]['name'],
            products[i]['price'].toDouble(),
            products[i]['quantity'].toDouble(),
            products[i]['rank'],
            false,
            products[i]['about'],
            products[i]['category']));
      }
    }

    if (filter_type == "price" && category == "Price High to Low") {
      loadedList.sort((a, b) => b.price.compareTo(a.price));
      return loadedList;
    } else if (filter_type == "price" && category == "Price Low to High") {
      loadedList.sort((a, b) => a.price.compareTo(b.price));
      print("low to high");
      return loadedList;
    }

    print(loadedList);
    return loadedList;
  }
}
