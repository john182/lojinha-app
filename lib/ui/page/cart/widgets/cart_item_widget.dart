import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/shared/widgets/icon_button_widget.dart';
import 'package:provider/provider.dart';

import 'cart_item_widget_controller.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemWidgetController controller;

  const CartItemWidget(this.controller);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: controller,
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
                    Image.network(controller.item.product?.images.first ?? ""),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    children: <Widget>[
                      Text(
                        controller.item.product?.name ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Tamanho: ${controller.item.size}',
                          style: const TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ),
                      Consumer<CartItemWidgetController>(
                        builder: (_, cartProduct, __) {
                          if (cartProduct.item.hasStock) {
                            return Text(
                                'R\$ ${controller.item.unitPrice.toStringAsFixed(2)}',
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
              Consumer<CartItemWidgetController>(builder: (_, controller, ___) {
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
    );
  }
}
