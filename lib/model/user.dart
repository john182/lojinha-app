import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/model/address.dart';

class User {
  String? id;
  String email;
  String password;
  String? confirmPassword;
  String? name;
  bool admin = false;
  Address? address;

  User(
      {this.id,
      required this.email,
      required this.password,
      this.name,
      this.address,
      this.confirmPassword});

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
        id: doc.get('id') as String,
        email: doc.get('email') as String,
        password: '',
        name: doc.get('name') as String,
        address: doc.data()!.containsKey('address')
            ? Address.fromMap(doc.get('address') as Map<String, dynamic>)
            : null);
  }

  Map<String, dynamic> get toJson {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['email'] = email;
    json['name'] = name;
    if (address != null) {
      json['name'] = address?.toMap();
    }
    return json;
  }
}

String encode(User user) {
  final jsonDados = user.toJson;
  return json.encode(jsonDados);
}
