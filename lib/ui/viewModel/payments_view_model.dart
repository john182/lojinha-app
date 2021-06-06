import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loja_virtual/infra/locator.dart';
import 'package:loja_virtual/model/order.dart';
import 'package:loja_virtual/model/user.dart';
import 'package:loja_virtual/service/order_service.dart';
import 'package:loja_virtual/service/product_service.dart';

class PaymentsViewModel extends ChangeNotifier {
  final OrderService _service = locator<OrderService>();
  final ProductService _productService = locator<ProductService>();
  User? user;
  List<Order> orders = [];
  StreamSubscription? _subscription;

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  updateUser(User? user) {
    this.user = user;

    if (user != null) {
      _listenToOrders(user);
    }
  }

  Future<void> checkout({
    required Order order,
    required User user,
    required Function onStockFail,
    required Function onSuccess,
  }) async {
    loading = true;
    try {
      await _service.decrementStock(order.items);
    } catch (e) {
      onStockFail(e);

      loading = false;
      debugPrint(e.toString());
      return;
    }

    final orderId = await _service.getOrderId();

    final newOrder = Order(
        items: List.from(order.items),
        price: order.price,
        userId: user.id,
        address: order.address);

    newOrder.orderId = orderId.toString();
    onSuccess();
    await _service.save(newOrder.orderId!, newOrder.toMap());
    loading = false;
  }

  void _listenToOrders(User user) {
    _subscription = _service.listenToOrders(user).listen((event) async {
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
