import 'package:flutter/material.dart';
import 'package:loja_virtual/model/order.dart';
import 'package:loja_virtual/ui/viewModel/admin_orders_view_model.dart';
import 'package:provider/provider.dart';

class StatusActionWdiget extends StatelessWidget {
  final Order order;

  const StatusActionWdiget({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AdminOrdersViewModel>();
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          TextButton(
            onPressed: () async {
              await viewModel.cancel(order);
            },
            style: TextButton.styleFrom(
              primary: Colors.red,
            ),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: viewModel.back(order),
            child: const Text('Recuar'),
          ),
          TextButton(
            onPressed: viewModel.advance(order),
            child: const Text('Avançar'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Endereço'),
          )
        ],
      ),
    );
  }
}
