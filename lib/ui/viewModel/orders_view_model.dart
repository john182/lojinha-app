import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loja_virtual/infra/locator.dart';
import 'package:loja_virtual/model/order.dart';
import 'package:loja_virtual/model/user.dart';
import 'package:loja_virtual/service/order_service.dart';
import 'package:loja_virtual/service/product_service.dart';

class OrdersViewModel extends ChangeNotifier {
  final OrderService _service = locator<OrderService>();
  final ProductService _productService = locator<ProductService>();
  User? user;
  List<Order> orders = [];

  StreamSubscription? _subscription;

  void updateUser(User? user) {
    this.user = user;
    orders.clear();

    _subscription?.cancel();
    if (user != null) {
      _listenToOrders(user);
    }
  }

  void _listenToOrders(User user) {
    _subscription = _service.listenToOrdersByUser(user).listen((event) async {
      for (final doc in event.docs) {
        final Map<String, dynamic> map = doc.data();
        map['orderId'] = doc.id;
        for (final map in map['items'] as List<dynamic>) {
          final idprod = map['productId'] as String;
          final product = await _productService.getProduct(idprod);
          final mapProd = product?.data();
          mapProd?['id'] = product?.id;
          map['product'] = mapProd;
        }

        orders.add(Order.fromMap(map));
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
