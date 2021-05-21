import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/view/page/adress/widgets/cep_label_info_widget.dart';
import 'package:loja_virtual/view/viewModel/cart_view_model.dart';
import 'package:provider/provider.dart';

import 'cep_input_field_widget.dart';

class CepSearchWidget extends StatelessWidget {
  const CepSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(builder: (_, viewModel, __) {
      return viewModel.address == null
          ? CepInputFieldWidget()
          : CepLabelInfoWidget(
              cep: viewModel.address!.zipCode,
              onTap: () => viewModel.removeAddress(),
            );
    });
  }
}
