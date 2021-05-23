import 'package:flutter/material.dart';
import 'package:loja_virtual/data/models/address.dart';

class AddressLabelInfoWidget extends StatelessWidget {
  final Address address;

  const AddressLabelInfoWidget({Key? key, required this.address})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text('${address.street}, ${address.number}\n${address.district}\n'
          '${address.city} - ${address.state}'),
    );
    ;
  }
}
