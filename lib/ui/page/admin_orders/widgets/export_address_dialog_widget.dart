import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:loja_virtual/model/address.dart';
import 'package:screenshot/screenshot.dart';

class ExportAddressDialogWidget extends StatelessWidget {
  final Address address;
  final ScreenshotController screenshotController = ScreenshotController();

  ExportAddressDialogWidget({Key? key, required this.address})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Endereço de Entrega'),
      content: Screenshot(
        controller: screenshotController,
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.white,
          child: Text(
            '${address.street}, ${address.number} ${address.complement}\n'
            '${address.district}\n'
            '${address.city}/${address.state}\n'
            '${address.zipCode}',
          ),
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            final Uint8List? file = await screenshotController.capture();
            //await GallerySaver.saveImage(file);
          },
          child: const Text('Exportar'),
        )
      ],
    );
  }
}
