import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loja_virtual/data/models/address.dart';
import 'package:loja_virtual/infra/locator.dart';
import 'package:loja_virtual/service/adddress_service.dart';
import 'package:loja_virtual/service/cep_aberto_service.dart';

class AddressViewModel extends ChangeNotifier {
  Address? address;
  final AddressService _service = locator<AddressService>();

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

  void setAddress(Address address) {
    this.address = address;

    calculateDelivery(address.lat, address.long);
  }

  void removeAddress() {
    address = null;
    notifyListeners();
  }

  Future<void> calculateDelivery(double lat, double long) async {
    final doc = await _service.getCoordinates();

    final latStore = doc.get('lat') as double;
    final longStore = doc.get('long') as double;

    final maxkm = doc.get('maxkm') as num;

    double dis =
        await Geolocator().distanceBetween(latStore, longStore, lat, long);

    dis /= 1000.0;

    print('Distance $dis');
  }
}
