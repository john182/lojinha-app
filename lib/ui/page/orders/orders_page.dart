import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/shared/widgets/empty_card_wdiget.dart';
import 'package:loja_virtual/ui/shared/widgets/menu/menu_widget.dart';
import 'package:loja_virtual/ui/shared/widgets/orders/orders_item_widget.dart';
import 'package:loja_virtual/ui/viewModel/orders_view_model.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuWidget(),
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
        centerTitle: true,
      ),
      body: Consumer<OrdersViewModel>(
        builder: (_, viewModel, __) {
          if (viewModel.orders.isEmpty) {
            return const EmptyCardWidget(
              title: 'Nenhuma compra encontrada!',
              iconData: Icons.border_clear,
            );
          }
          return ListView.builder(
              itemCount: viewModel.orders.length,
              itemBuilder: (_, index) {
                return OrdersItemWidget(
                  order: viewModel.orders.reversed.toList()[index],
                );
              });
        },
      ),
    );
  }
}
