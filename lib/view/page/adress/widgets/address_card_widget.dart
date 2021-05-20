import 'package:flutter/material.dart';

import 'cep_input_field_widget.dart';

class AddressCardWidget extends StatelessWidget {
  const AddressCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
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
            CepInputFieldWidget()
          ],
        ),
      ),
    );
  }
}
