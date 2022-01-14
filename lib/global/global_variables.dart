import 'package:groceryapptesting/models/GroceryProduct.dart';
import 'package:groceryapptesting/repositories/ProductsRepository.dart';

// List<Product> productList = [];
List<Product> productList =
    ProductsRepository().get_data("category", "test") as List<Product>;
