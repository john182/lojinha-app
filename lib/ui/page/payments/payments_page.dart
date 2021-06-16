import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/shared/widgets/price_cart_widget.dart';
import 'package:loja_virtual/ui/viewModel/cart_view_model.dart';
import 'package:loja_virtual/ui/viewModel/login_view_model.dart';
import 'package:loja_virtual/ui/viewModel/payments_view_model.dart';
import 'package:provider/provider.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.watch<LoginViewModel>();
    final cartViewModel = context.watch<CartViewModel>();
    return ChangeNotifierProvider(
      create: (_) => PaymentsViewModel(),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Payments'),
          ),
          body: Consumer<PaymentsViewModel>(
            builder: (_, viewModel, __) {
              if (viewModel.loading) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).primaryColor),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Processando seu pagamento...',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 16),
                      )
                    ],
                  ),
                );
              }

              return ListView(
                children: [
                  PriceCardWidget(
                    buttonText: "Finalizar Pedido",
                    onPressed: () {
                      viewModel.checkout(
                          order: cartViewModel.order,
                          user: userViewModel.user!,
                          onStockFail: (e) {
                            cartViewModel.notify();
                            Navigator.of(context).popUntil(
                                (route) => route.settings.name == '/cart');
                          },
                          onSuccess: (order) async {
                            cartViewModel.clear();
                            Navigator.of(context).popUntil(
                                (route) => route.settings.name == '/');
                            Navigator.of(context)
                                .pushNamed('/confirmation', arguments: order);
                          });
                    },
                  ),
                ],
              );
            },
          )),
    );
  }
}
