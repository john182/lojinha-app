import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/infra/locator.dart';
import 'package:loja_virtual/model/item_size.dart';
import 'package:loja_virtual/service/product_service.dart';

class ProductViewModel extends ChangeNotifier {
  ItemSize? _selectedSize;

  ItemSize? get selectedSize => _selectedSize;

  final ProductService _service = locator<ProductService>();

  set selectedSize(ItemSize? value) {
    _selectedSize = value;
    notifyListeners();
  }

  Color getColorBorder(BuildContext context, ItemSize itemSize) {
    Color color;
    if (!itemSize.hasStock) {
      color = Colors.red.withAlpha(50);
    } else if (_selectedSize == itemSize) {
      color = Theme.of(context).primaryColor;
    } else {
      color = Colors.grey;
    }
    return color;
  }
}
