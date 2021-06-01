import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/infra/locator.dart';
import 'package:loja_virtual/model/ordem_item.dart';
import 'package:loja_virtual/model/order.dart';
import 'package:loja_virtual/model/product.dart';
import 'package:loja_virtual/model/user.dart';
import 'package:loja_virtual/service/product_service.dart';
import 'package:loja_virtual/service/user_service.dart';

class CartViewModel extends ChangeNotifier {
  User? user;

  Order order = Order.init();

  final UserService _service = locator<UserService>();
  final ProductService _serviceProduct = locator<ProductService>();

  void clear() {
    for (final item in order.items) {
      _service.removeCart(item);
    }

    order = Order.init();

    notifyListeners();
  }

  void addToCart(Product product, String size) {
    try {
      final item = order.items.firstWhere(
          (prod) => product.id == prod.productId && prod.size == size);
      item.quantity++;
    } catch (e) {
      final cartProduct = OrderItem.fromProduct(product, size);
      order.items.add(cartProduct);
      _service.cartReference
          .add(cartProduct.toMap())
          .then((doc) => cartProduct.id = doc.id);
    }

    calcAmount();
  }

  void removeOfCart(OrderItem cartProduct) {
    order.items.removeWhere((p) => p.id == cartProduct.id);

    _service.removeCart(cartProduct);

    notifyListeners();
  }

  void updateUser(User? user) {
    this.user = user;
    order.items.clear();

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
      final item = OrderItem.fromDocument(doc);

      item.product = product;
      order.items.add(item);
      order.price += item.totalPrice;
    }
  }

  void calcAmount() {
    order.price = order.items.isNotEmpty
        ? order.items
            .map((e) => e.totalPrice)
            .reduce((value, element) => value + element)
        : 0.0;
  }

  void updatePrice() {
    calcAmount();
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }

  bool get isCartValid {
    for (final cartProduct in order.items) {
      if (!cartProduct.hasStock) return false;
    }
    return true;
  }
}
