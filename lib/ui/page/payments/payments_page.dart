import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/shared/widgets/price_cart_widget.dart';
import 'package:loja_virtual/ui/viewModel/login_view_model.dart';
import 'package:provider/provider.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.watch<LoginViewModel>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Payments'),
      ),
      body: ListView(
        children: [
          PriceCardWidget(
            buttonText: "Finalizar Pedido",
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
