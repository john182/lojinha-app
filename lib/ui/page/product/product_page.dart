import 'package:flutter/material.dart';
import 'package:loja_virtual/model/product.dart';
import 'package:loja_virtual/ui/viewModel/cart_view_model.dart';
import 'package:loja_virtual/ui/viewModel/login_view_model.dart';
import 'package:loja_virtual/ui/viewModel/product_view_model.dart';
import 'package:provider/provider.dart';

import 'widgets/size_widget.dart';

class ProductPage extends StatelessWidget {
  const ProductPage(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        centerTitle: true,
        actions: <Widget>[
          Consumer<LoginViewModel>(
            builder: (_, controlelr, __) {
              if (controlelr.adminEnabled) {
                return IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/edit_product',
                        arguments: product);
                  },
                );
              }
              return Container();
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: Image.network(product.images.first),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'A partir de',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                ),
                Text(
                  'R\$ 19.99',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    'Descrição',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  product.description,
                  style: const TextStyle(fontSize: 16),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    'Tamanhos',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: product.sizes.map((s) {
                    return SizeWidget(s);
                  }).toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (product.hasStock)
                  Consumer2<LoginViewModel, ProductViewModel>(
                    builder: (_, userViewModel, productViewmModel, __) {
                      return SizedBox(
                        height: 44,
                        child: ElevatedButton(
                          onPressed: productViewmModel.selectedSize != null
                              ? () {
                                  if (userViewModel.isLoggedIn) {
                                    context.read<CartViewModel>().addToCart(
                                        product,
                                        productViewmModel.selectedSize!.name);
                                    Navigator.of(context).pushNamed('/cart');
                                  } else {
                                    Navigator.of(context).pushNamed('/singin');
                                  }
                                }
                              : null,
                          child: Text(
                            userViewModel.isLoggedIn
                                ? 'Adicionar ao Carrinho'
                                : 'Entre para Comprar',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      );
                    },
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
