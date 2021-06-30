import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/shared/widgets/empty_card_wdiget.dart';
import 'package:loja_virtual/ui/shared/widgets/icon_button_widget.dart';
import 'package:loja_virtual/ui/shared/widgets/menu/menu_widget.dart';
import 'package:loja_virtual/ui/shared/widgets/orders/orders_item_widget.dart';
import 'package:loja_virtual/ui/viewModel/admin_orders_view_model.dart';
import 'package:provider/provider.dart';

class AdminOrdersPage extends StatelessWidget {
  const AdminOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuWidget(),
      appBar: AppBar(
        title: const Text('Meus Pedidos 2'),
        centerTitle: true,
      ),
      body: Consumer<AdminOrdersViewModel>(
        builder: (_, viewModel, __) {
          final filteredOrders = viewModel.filteredOrders;

          return Column(
            children: [
              if (viewModel.userFilter != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 2),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Pedidos de ${viewModel.userFilter?.name ?? ""}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                      IconButtonWidget(
                        iconData: Icons.close,
                        color: Colors.black45,
                        onTap: () {
                          viewModel.setUserFilter(null);
                        },
                      )
                    ],
                  ),
                ),
              if (filteredOrders.isEmpty)
                const Expanded(
                  child: EmptyCardWidget(
                    title: 'Nenhuma compra encontrada!',
                    iconData: Icons.border_clear,
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredOrders.length,
                    itemBuilder: (_, index) {
                      return OrdersItemWidget(
                        showControls: true,
                        order: filteredOrders.reversed.toList()[index],
                      );
                    },
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
