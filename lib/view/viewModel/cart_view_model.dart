import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/infra/locator.dart';
import 'package:loja_virtual/model/cart_product_model.dart';
import 'package:loja_virtual/model/product.dart';
import 'package:loja_virtual/model/user.dart';
import 'package:loja_virtual/service/product_service.dart';
import 'package:loja_virtual/service/user_service.dart';

class CartViewModel extends ChangeNotifier {
  List<CartProductModel> items = [];
  User? user;
  num productsPrice = 0.0;

  final UserService _service = locator<UserService>();
  final ProductService _serviceProduct = locator<ProductService>();

  void addToCart(Product product, String size) {
    try {
      final item = items.firstWhere(
          (prod) => product.id == prod.productId && prod.size == size);
      item.quantity++;
    } catch (e) {
      final cartProduct = CartProductModel.fromProduct(product, size);
      items.add(cartProduct);
      _service.cartReference
          .add(cartProduct.toMap())
          .then((doc) => cartProduct.id = doc.id);
    }

    calcAmount();
  }

  void removeOfCart(CartProductModel cartProduct) {
    items.removeWhere((p) => p.id == cartProduct.id);

    _service.removeCart(cartProduct);

    notifyListeners();
  }

  void updateUser(User? user) {
    this.user = user;
    items.clear();

    if (user != null) {
      _loadCartItems();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await _service.cartReference.get();

    for (final doc in cartSnap.docs) {
      final docProd =
          await _serviceProduct.getProduct(doc.get('pid') as String);
      final product = Product.fromDocument(docProd!);
      final item = CartProductModel.fromDocument(doc);

      item.product = product;
      items.add(item);
      productsPrice += item.totalPrice;
    }
  }

  void calcAmount() {
    productsPrice = items.isNotEmpty
        ? items
            .map((e) => e.totalPrice)
            .reduce((value, element) => value + element)
        : 0.0;
  }

  void updatePrice() {
    calcAmount();
    notifyListeners();
  }

  bool get isCartValid {
    for (final cartProduct in items) {
      if (!cartProduct.hasStock) return false;
    }
    return true;
  }
}
