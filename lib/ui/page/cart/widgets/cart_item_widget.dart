import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/shared/widgets/icon_button_widget.dart';
import 'package:provider/provider.dart';

import '../../../viewModel/cart_item_view_modell.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemViewModel viewModel;

  const CartItemWidget(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            '/product',
            arguments: viewModel.item.product,
          );
        },
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 80,
                  width: 80,
                  child:
                      Image.network(viewModel.item.product?.images.first ?? ""),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      children: <Widget>[
                        Text(
                          viewModel.item.product?.name ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Tamanho: ${viewModel.item.size}',
                            style: const TextStyle(fontWeight: FontWeight.w300),
                          ),
                        ),
                        Consumer<CartItemViewModel>(
                          builder: (_, cartProduct, __) {
                            if (cartProduct.item.hasStock) {
                              return Text(
                                  'R\$ ${viewModel.item.unitPrice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ));
                            }

                            return const Text(
                              'Sem estoque suficiente',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Consumer<CartItemViewModel>(builder: (_, controller, ___) {
                  return Column(
                    children: [
                      IconButtonWidget(
                        iconData: Icons.add,
                        color: Theme.of(context).primaryColor,
                        onTap: controller.increment,
                      ),
                      Text(
                        '${controller.item.quantity}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      IconButtonWidget(
                        iconData: Icons.remove,
                        color: controller.item.quantity > 1
                            ? Theme.of(context).primaryColor
                            : Colors.red,
                        onTap: controller.decrement,
                      ),
                    ],
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
