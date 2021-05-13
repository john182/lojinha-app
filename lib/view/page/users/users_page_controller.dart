import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/infra/locator.dart';
import 'package:loja_virtual/model/user.dart';
import 'package:loja_virtual/service/user_service.dart';

class UsersPageController extends ChangeNotifier {
  List<User> users = [];
  List<String> names = [];

  final UserService _service = locator<UserService>();

  void updateUser(bool adminEnabled) {
    if (adminEnabled) {
      _listenToUsers();
    }
  }

  Future<void> _listenToUsers() async {
    final QuerySnapshot snapUsers = await _service.getUsers();

    users = snapUsers.docs.map((d) => User.fromDocument(d)).toList();

    users
        .sort((a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));

    names = users.map((e) => e.name!).toList();

    notifyListeners();
  }
}
