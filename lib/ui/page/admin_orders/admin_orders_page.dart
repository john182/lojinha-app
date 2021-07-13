import 'package:flutter/material.dart';
import 'package:loja_virtual/infra/ext/status_order_ext.dart';
import 'package:loja_virtual/model/order.dart';
import 'package:loja_virtual/ui/shared/widgets/empty_card_wdiget.dart';
import 'package:loja_virtual/ui/shared/widgets/icon_button_widget.dart';
import 'package:loja_virtual/ui/shared/widgets/menu/menu_widget.dart';
import 'package:loja_virtual/ui/shared/widgets/orders/orders_item_widget.dart';
import 'package:loja_virtual/ui/viewModel/admin_orders_view_model.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AdminOrdersPage extends StatelessWidget {
  final PanelController panelController = PanelController();

  AdminOrdersPage({Key? key}) : super(key: key);

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

          return SlidingUpPanel(
            controller: panelController,
            minHeight: 40,
            maxHeight: 280,
            body: Column(
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
                  ),
                const SizedBox(height: 120)
              ],
            ),
            panel: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {
                    if (panelController.isPanelClosed) {
                      panelController.open();
                    } else {
                      panelController.close();
                    }
                  },
                  child: Container(
                    height: 40,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text(
                      'Filtros',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: Status.values.map((s) {
                      return CheckboxListTile(
                          title: Text(s.name),
                          value: viewModel.statusFilter.contains(s),
                          dense: true,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (v) {
                            viewModel.setStatusFilter(
                                status: s, enabled: v ?? false);
                          });
                    }).toList(),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
