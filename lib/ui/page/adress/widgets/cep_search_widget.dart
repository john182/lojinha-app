import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/ui/page/adress/widgets/cep_label_info_widget.dart';
import 'package:loja_virtual/ui/viewModel/address_view_model.dart';
import 'package:provider/provider.dart';

import 'cep_input_field_widget.dart';

class CepSearchWidget extends StatelessWidget {
  const CepSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressViewModel>(builder: (_, viewModel, __) {
      return viewModel.address == null
          ? CepInputFieldWidget()
          : CepLabelInfoWidget(
              cep: viewModel.address!.zipCode,
              onTap: () => viewModel.removeAddress(),
            );
    });
  }
}
