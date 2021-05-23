import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/page/adress/widgets/address_label_info_widget.dart';
import 'package:loja_virtual/ui/page/adress/widgets/cep_search_widget.dart';
import 'package:loja_virtual/ui/viewModel/address_view_model.dart';
import 'package:provider/provider.dart';

import 'address_input_field_widget.dart';

class AddressCardWidget extends StatelessWidget {
  const AddressCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Consumer<AddressViewModel>(
          builder: (_, viewModel, __) {
            final address = viewModel.address;

            return Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Endereço de Entrega',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const CepSearchWidget(),
                  if (address != null && !viewModel.calculateDeliveryPrice)
                    AddressInputFieldWidget(address: address),
                  if (viewModel.calculateDeliveryPrice)
                    AddressLabelInfoWidget(address: address!)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
