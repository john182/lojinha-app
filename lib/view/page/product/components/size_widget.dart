import 'package:flutter/material.dart';
import 'package:loja_virtual/model/item_size.dart';
import 'package:loja_virtual/view/viewModel/product_view_model.dart';
import 'package:provider/provider.dart';

class SizeWidget extends StatelessWidget {
  const SizeWidget(this.size);

  final ItemSize size;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProductViewModel>();

    final color = viewModel.getColorBorder(context, size);

    return GestureDetector(
      onTap: () {
        if (size.hasStock) {
          viewModel.selectedSize = size;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: color),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              color: color,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                size.name,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'R\$ ${size.price.toStringAsFixed(2)}',
                style: TextStyle(
                  color: color,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
