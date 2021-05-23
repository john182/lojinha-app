import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/ui/shared/widgets/button_loading_widget.dart';
import 'package:loja_virtual/ui/viewModel/address_view_model.dart';
import 'package:provider/provider.dart';

class CepInputFieldWidget extends StatelessWidget {
  final String? cep;

  final TextEditingController cepController = TextEditingController();

  CepInputFieldWidget({Key? key, this.cep}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextFormField(
          controller: cepController,
          decoration: const InputDecoration(
              isDense: true, labelText: 'CEP', hintText: '12.345-678'),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            CepInputFormatter(),
          ],
          keyboardType: TextInputType.number,
          validator: (cep) {
            if (cep!.isEmpty) {
              return 'Campo obrigatório';
            } else if (cep.length != 10) {
              return 'CEP Inválido';
            }
            return null;
          },
        ),
        Consumer<AddressViewModel>(
          builder: (_, viewModel, __) {
            return ButtonLoadingWidget(
              loading: viewModel.loadingCep,
              onPressed: () {
                if (Form.of(context)!.validate()) {
                  viewModel.getAddress(cepController.text);
                }
              },
              label: 'Buscar CEP',
            );
          },
        ),
      ],
    );
  }
}
