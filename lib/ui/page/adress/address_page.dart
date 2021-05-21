import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/page/adress/widgets/address_card_widget.dart';

class AdrressPage extends StatelessWidget {
  const AdrressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrega'),
        centerTitle: true,
      ),
      body: ListView(
        children: const [
          AddressCardWidget(),
        ],
      ),
    );
  }
}
