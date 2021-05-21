import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/view/viewModel/cart_view_model.dart';
import 'package:provider/provider.dart';

class CepInputFieldWidget extends StatelessWidget {
  final String? cep;

  final TextEditingController cepController = TextEditingController();

  CepInputFieldWidget({Key? key, this.cep}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

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
        ElevatedButton(
          onPressed: () {
            if (Form.of(context)!.validate()) {
              context.read<CartViewModel>().getAddress(cepController.text);
            }
          },
          child: const Text('Buscar CEP'),
        ),
      ],
    );
  }
}
