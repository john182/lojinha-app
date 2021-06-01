import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/page/adress/widgets/address_card_widget.dart';
import 'package:loja_virtual/ui/shared/widgets/price_cart_widget.dart';
import 'package:loja_virtual/ui/viewModel/address_view_model.dart';
import 'package:loja_virtual/ui/viewModel/cart_view_model.dart';
import 'package:provider/provider.dart';

class AdrressPage extends StatelessWidget {
  const AdrressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartViewModel = context.watch<CartViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrega'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const AddressCardWidget(),
          Consumer<AddressViewModel>(
            builder: (_, viewModel, __) {
              cartViewModel.order.address = viewModel.address;
              viewModel.initAddress(cartViewModel.user?.address);

              return PriceCardWidget(
                buttonText: 'Continuar para o Pagamento',
                onPressed: !viewModel.calculateDeliveryPrice
                    ? null
                    : () {
                        Navigator.of(context).pushNamed("/payments");
                      },
              );
            },
          ),
        ],
      ),
    );
  }
}
