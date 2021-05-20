import 'dart:io';

import 'package:dio/dio.dart';

const token = '5553ff0f583dab10b2e9e8aef36dcc88';

class CepAbertoService {
  Future<void> getAddressFromCep(String cep) async {
    final cleanCep = cep.replaceAll('.', '').replaceAll('-', '');
    final endpoint = "https://www.cepaberto.com/api/v3/cep?cep=$cleanCep";

    final Dio dio = Dio();

    dio.options.headers[HttpHeaders.authorizationHeader] = 'Token token=$token';

    try {
      final response = await dio.get<Map>(endpoint);

      if (response.data!.isEmpty) {
        return Future.error('CEP Inválido');
      }

      print(response.data);
    } on DioError catch (e) {
      return Future.error('Erro ao buscar CEP');
    }
  }
}
