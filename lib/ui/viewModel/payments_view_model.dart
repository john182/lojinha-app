import 'package:flutter/material.dart';
import 'package:loja_virtual/infra/locator.dart';
import 'package:loja_virtual/model/order.dart';
import 'package:loja_virtual/model/user.dart';
import 'package:loja_virtual/service/order_service.dart';

class PaymentsViewModel extends ChangeNotifier {
  final OrderService _service = locator<OrderService>();

  Future<void> checkout(
      {required Order order, Function? onStockFail, required User user}) async {
    try {
      await _service.decrementStock(order.items);
    } catch (e) {
      if (onStockFail != null) {
        onStockFail(e);
      }

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

    await _service.save(order.orderId!, newOrder.toMap());
  }
}
