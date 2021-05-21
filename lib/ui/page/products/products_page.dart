import 'package:flutter/material.dart';
import 'package:loja_virtual/model/product.dart';
import 'package:loja_virtual/ui/page/products/widgets/search_dialog_widget.dart';
import 'package:loja_virtual/ui/shared/menu/menu_widget.dart';
import 'package:loja_virtual/ui/viewModel/login_view_model.dart';
import 'package:loja_virtual/ui/viewModel/products_view_model.dart';
import 'package:provider/provider.dart';

import 'widgets/producsts_item_widget.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuWidget(),
      appBar: AppBar(
        title: Consumer<ProductsViewModel>(
          builder: (_, viewModel, __) {
            if (viewModel.search.isEmpty) {
              return const Text('Produtos');
            } else {
              return LayoutBuilder(
                builder: (_, constraints) {
                  return GestureDetector(
                    onTap: () async {
                      await search(context, viewModel);
                    },
                    child: Container(
                        width: constraints.biggest.width,
                        child: Text(
                          viewModel.search,
                          textAlign: TextAlign.center,
                        )),
                  );
                },
              );
            }
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          Consumer<ProductsViewModel>(
            builder: (_, viewModel, __) {
              if (viewModel.search.isEmpty) {
                return IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () async {
                    await search(context, viewModel);
                  },
                );
              } else {
                return IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () async {
                    viewModel.search = '';
                  },
                );
              }
            },
          ),
          Consumer<LoginViewModel>(
            builder: (_, userControll, __) {
              if (userControll.adminEnabled) {
                return IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/edit_product',
                        arguments: Product(
                            name: '', description: '', images: [], sizes: []));
                  },
                );
              } else {
                return Container();
              }
            },
          )
        ],
      ),
      body: Consumer<ProductsViewModel>(
        builder: (_, viewModel, __) {
          final filteredProducts = viewModel.filteredProducts;
          return ListView.builder(
              padding: const EdgeInsets.all(4),
              itemCount: filteredProducts.length,
              itemBuilder: (_, index) {
                return ProductsItemWidget(filteredProducts[index]);
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).pushNamed('/cart');
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }

  Future<void> search(BuildContext context, ProductsViewModel viewModel) async {
    final search = await showDialog<String>(
        context: context, builder: (_) => SearchDialogWidget(viewModel.search));
    if (search != null) {
      viewModel.search = search;
    }
  }
}
