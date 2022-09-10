import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';

class BagViewModel extends ChangeNotifier {
  List<Product> productsBag;
  BagViewModel() : productsBag = [];

  void addProduct(Product product) {
    productsBag.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    productsBag.remove(product);
    notifyListeners();
  }

  void clearbag() {
    productsBag.clear();
    notifyListeners();
  }

  int get totalProducts => productsBag.length;
  double get totalPrice =>
      productsBag.fold(0, (total, product) => total + product.price);
  bool get isbagEmpty => productsBag.isEmpty;
}
