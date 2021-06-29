import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loja_virtual/infra/locator.dart';
import 'package:loja_virtual/model/order.dart';
import 'package:loja_virtual/model/user.dart';
import 'package:loja_virtual/service/order_service.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderService _service = locator<OrderService>();

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> checkout({
    required Order order,
    required User user,
    required Function onStockFail,
    required Function(Order order) onSuccess,
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
    onSuccess(newOrder);
    await _service.save(newOrder.orderId!, newOrder.toMap());
    loading = false;
  }

}
