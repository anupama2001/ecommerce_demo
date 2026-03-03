import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../data/dummy_data.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = List.from(dummyProducts);

  List<Product> _displayedProducts = List.from(dummyProducts);

  List<Product> get products => _displayedProducts;

  void filterByCategory(String category) {
    if (category == "All") {
      _displayedProducts = List.from(_products);
    } else {
      _displayedProducts = _products
          .where((product) => product.category == category)
          .toList();
    }

    notifyListeners();
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      _displayedProducts = List.from(_products);
    } else {
      _displayedProducts = _products.where((product) {
        return product.title
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    }

    notifyListeners();
  }

  void resetProducts() {
    _displayedProducts = List.from(_products);
    notifyListeners();
  }
}