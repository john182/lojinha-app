import 'package:flutter/material.dart';
import 'package:loja_virtual/model/cart_product_model.dart';
import 'package:loja_virtual/ui/page/cart/widgets/cart_item_widget.dart';
import 'package:loja_virtual/ui/page/cart/widgets/empty_cart_widget.dart';
import 'package:loja_virtual/ui/shared/widgets/price_cart_widget.dart';
import 'package:loja_virtual/ui/viewModel/cart_item_view_modell.dart';
import 'package:loja_virtual/ui/viewModel/cart_view_model.dart';
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
          debugPrint(viewModel.items.length.toString());
          return viewModel.items.isEmpty
              ? const EmptyCart(
                  title: 'Nenhum produto no carrinho!',
                  iconData: Icons.remove_shopping_cart,
                )
              : ListView(
                  children: [
                    Column(
                      children: viewModel.items
                          .map(
                              (cartProduct) => CartItemWidget(CartItemViewModel(
                                  item: cartProduct,
                                  onRemove: (item) {
                                    viewModel
                                        .removeOfCart(item as CartProductModel);
                                  },
                                  onUpdateQuantity: () {
                                    viewModel.updatePrice();
                                  })))
                          .toList(),
                    ),
                    PriceCardWidget(
                      buttonText: 'Continuar para Entrega',
                      onPressed:
                          viewModel.isCartValid && viewModel.items.isNotEmpty
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
