import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loja_virtual/infra/locator.dart';
import 'package:loja_virtual/model/order.dart';
import 'package:loja_virtual/service/order_service.dart';
import 'package:loja_virtual/service/product_service.dart';

class AdminOrdersViewModel extends ChangeNotifier {
  final OrderService _service = locator<OrderService>();
  final ProductService _productService = locator<ProductService>();

  List<Order> orders = [];
  StreamSubscription? _subscription;

  Function()? back(Order order) {
    return order.status.index >= Status.transporting.index
        ? () async {
            await _changeStatus(order.orderId!, order.status.index - 1);
          }
        : null;
  }

  Function()? advance(Order order) {
    return order.status.index <= Status.transporting.index
        ? () async {
            await _changeStatus(order.orderId!, order.status.index + 1);
          }
        : null;
  }

  Future<void> cancel(Order order) async {
    await _changeStatus(order.orderId!, Status.canceled.index);
  }

  void updateAdmin({required bool adminEnabled}) {
    orders.clear();

    _subscription?.cancel();
    if (adminEnabled) {
      _listenToOrders();
    }
  }

  void _listenToOrders() {
    _subscription = _service.listenToOrders().listen((event) async {
      orders.clear();
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

  Future<void> _changeStatus(String id, int status) async {
    await _service.updateStatus(id, status);
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
