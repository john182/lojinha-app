import 'package:flutter/material.dart';
import 'package:loja_virtual/data/models/address.dart';
import 'package:loja_virtual/service/cep_aberto_service.dart';

class AddressViewModel extends ChangeNotifier {
  Address? address;

  Future<void> getAddress(String cep) async {
    final cepAbertoService = CepAbertoService();

    try {
      final result = await cepAbertoService.getAddressFromCep(cep);

      address = Address(
          street: result.logradouro,
          district: result.bairro,
          zipCode: result.cep,
          city: result.cidade.nome,
          state: result.estado.sigla,
          lat: result.latitude,
          long: result.longitude,
          complement: '',
          number: '');
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void removeAddress() {
    address = null;
    notifyListeners();
  }
}
