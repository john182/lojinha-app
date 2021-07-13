import 'package:flutter/material.dart';
import 'package:loja_virtual/model/order.dart';
import 'package:loja_virtual/ui/viewModel/admin_orders_view_model.dart';
import 'package:provider/provider.dart';

class CancelOrderDialogWidget extends StatelessWidget {
  final Order order;

  const CancelOrderDialogWidget({Key? key, required this.order})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AdminOrdersViewModel>();

    return AlertDialog(
      title: Text('Cancelar ${order.formattedId}?'),
      content: const Text('Esta ação não poderá ser defeita!'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            viewModel.cancel(order);
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancelar Pedido',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
