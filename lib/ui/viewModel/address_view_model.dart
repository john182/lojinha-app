import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loja_virtual/infra/locator.dart';
import 'package:loja_virtual/model/address.dart';
import 'package:loja_virtual/service/adddress_service.dart';
import 'package:loja_virtual/service/cep_aberto_service.dart';

class AddressViewModel extends ChangeNotifier {
  Address? address;
  String? zipCode;
  final AddressService _service = locator<AddressService>();

  num productsPrice = 0.0;
  num deliveryPrice = 0;
  bool _loadingCep = false;
  bool _calculateCoordinates = false;
  bool _calculateDeliveryPrice = false;

  bool get calculateCoordinates => _calculateCoordinates;

  set calculateCoordinates(bool value) {
    _calculateCoordinates = value;
    notifyListeners();
  }

  bool get loadingCep => _loadingCep;

  set loadingCep(bool value) {
    _loadingCep = value;
  }

  bool get calculateDeliveryPrice => _calculateDeliveryPrice;

  set calculateDeliveryPrice(bool value) {
    _calculateDeliveryPrice = value;
    notifyListeners();
  }

  Future<void> getAddress(String cep, Function(String msg) onFail) async {
    loadingCep = true;
    zipCode = cep;
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
    } catch (e) {
      onFail("CEP invalido");
      debugPrint(e.toString());
    } finally {
      loadingCep = false;
      notifyListeners();
    }
  }

  void setAddress(Address newAddress) {
    this.address = newAddress;
  }

  void removeAddress() {
    address = null;
    zipCode = null;
    calculateDeliveryPrice = false;
    notifyListeners();
  }

  Future<void> calculateDelivery(double lat, double long,
      Function(String msg) onFail, Function? onSuccess) async {
    calculateCoordinates = true;
    final doc = await _service.getCoordinates();

    final latStore = doc.get('lat') as double;
    final longStore = doc.get('long') as double;
    final maxkm = doc.get('maxkm') as num;
    final base = doc.get('base') as num;
    final km = doc.get('km') as num;

    double dis = Geolocator.distanceBetween(latStore, longStore, lat, long);

    dis /= 1000.0;

    debugPrint('Distance $dis');
    calculateCoordinates = false;

    if (dis > maxkm) {
      onFail("Endereço fora do raio de entrega");
      notifyListeners();
      return;
    }

    deliveryPrice = base + dis * km;
    calculateDeliveryPrice = true;
    notifyListeners();
  }
}
