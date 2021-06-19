import 'package:flutter/material.dart';
import 'package:loja_virtual/infra/ext/status_order_ext.dart';
import 'package:loja_virtual/model/order.dart';
import 'package:loja_virtual/ui/page/admin_orders/widgets/status_action_widget.dart';
import 'package:loja_virtual/ui/shared/widgets/orders/orders_item_detail_widget.dart';

class OrdersItemWidget extends StatelessWidget {
  final Order order;
  final bool showControls;

  const OrdersItemWidget(
      {Key? key, required this.order, this.showControls = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  order.formattedId,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  'R\$ ${order.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Text(
              order.status.name,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color:
                    order.status == Status.canceled ? Colors.red : primaryColor,
                fontSize: 14,
              ),
            )
          ],
        ),
        children: [
          Column(
            children: order.items
                .map((e) => OrdersItemDatailWidget(item: e))
                .toList(),
          ),
          if (showControls && order.status != Status.canceled)
            StatusActionWdiget(order: order)
        ],
      ),
    );
  }
}
