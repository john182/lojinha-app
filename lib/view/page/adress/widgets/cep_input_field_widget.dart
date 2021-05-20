import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CepInputFieldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextFormField(
          decoration: const InputDecoration(
              isDense: true, labelText: 'CEP', hintText: '12.345-678'),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          ],
          keyboardType: TextInputType.number,
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Buscar CEP'),
        ),
      ],
    );
  }
}
