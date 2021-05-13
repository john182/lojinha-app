import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  String email;
  String password;
  String? confirmPassword;
  String? name;
  bool admin = false;

  User(
      {this.id,
      required this.email,
      required this.password,
      this.name,
      this.confirmPassword});

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
        email: doc.get('email') as String,
        password: '',
        name: doc.get('name') as String);
  }

  Map<String, dynamic> get toJson {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['email'] = email;
    json['name'] = name;
    return json;
  }
}

String encode(User user) {
  final jsonDados = user.toJson;
  return json.encode(jsonDados);
}
