import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/infra/locator.dart';
import 'package:loja_virtual/model/product.dart';
import 'package:loja_virtual/service/product_service.dart';

class ProductsViewModel extends ChangeNotifier {
  final ProductService _service = locator<ProductService>();

  ProductsViewModel() {
    _loadAllProducts();
  }

  List<Product> allProducts = [];

  String _search = '';

  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  Future<void> _loadAllProducts() async {
    allProducts = await _service.loadAllProducts();

    notifyListeners();
  }

  List<Product> get filteredProducts {
    final List<Product> filteredProducts = search.isEmpty
        ? allProducts
        : allProducts
            .where((p) => p.name.toLowerCase().contains(search.toLowerCase()))
            .toList();

    return filteredProducts;
  }

  Product? findProductById(String id) {
    try {
      return allProducts.firstWhere((prod) => prod.id == id);
    } catch (e) {
      return null;
    }
  }
}
