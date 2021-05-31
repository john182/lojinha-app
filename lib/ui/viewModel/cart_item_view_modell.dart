import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/infra/locator.dart';
import 'package:loja_virtual/model/ordem_item.dart';
import 'package:loja_virtual/service/user_service.dart';

class CartItemViewModel extends ChangeNotifier {
  OrderItem item;
  final Function onUpdateQuantity;
  final Function onRemove;

  final UserService _service = locator<UserService>();

  CartItemViewModel(
      {required this.item,
      required this.onRemove,
      required this.onUpdateQuantity});

  void increment() {
    item.quantity++;
    _updateCartProduct();

    onUpdateQuantity();
    notifyListeners();
  }

  void decrement() {
    if (item.quantity == 1) {
      onRemove(item);
    } else {
      item.quantity--;
      _updateCartProduct();
    }

    onUpdateQuantity();

    notifyListeners();
  }

  void _updateCartProduct() {
    _service.updateCartProduct(item);
  }
}
