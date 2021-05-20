import 'package:flutter/material.dart';
import 'package:loja_virtual/model/cart_product_model.dart';
import 'package:loja_virtual/view/page/cart/widgets/cart_item_widget.dart';
import 'package:loja_virtual/view/page/cart/widgets/cart_item_widget_controller.dart';
import 'package:loja_virtual/view/shared/widgets/price_cart_widget.dart';
import 'package:loja_virtual/view/viewModel/cart_view_model.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
      ),
      body: Consumer<CartViewModel>(
        builder: (_, viewModel, __) {
          return ListView(
            children: [
              Column(
                children: viewModel.items
                    .map((cartProduct) =>
                        CartItemWidget(CartItemWidgetController(
                            item: cartProduct,
                            onRemove: (item) {
                              viewModel.removeOfCart(item as CartProductModel);
                            },
                            onUpdateQuantity: () {
                              viewModel.updatePrice();
                            })))
                    .toList(),
              ),
              PriceCardWidget(
                buttonText: 'Continuar para Entrega',
                onPressed: viewModel.isCartValid && viewModel.items.isNotEmpty
                    ? () {
                        Navigator.of(context).pushNamed('/address');
                      }
                    : null,
              ),
            ],
          );
        },
      ),
    );
  }
}
