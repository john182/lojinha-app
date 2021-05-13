import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/infra/locator.dart';
import 'package:loja_virtual/model/user.dart';
import 'package:loja_virtual/service/user_service.dart';

class LoginViewModel extends ChangeNotifier {
  final UserService _service = locator<UserService>();

  bool _loading = false;
  User? user;

  bool get loading => _loading;

  bool get isLoggedIn => user != null;

  LoginViewModel() {
    _loadCurrentUser();
  }

  Future<void> signIn(
      {required User user, Function? onFail, Function? onSuccess}) async {
    loading = true;
    final result =
        await _service.signIn(user: user, onFail: onFail, onSuccess: onSuccess);

    if (result != null) {
      findUser(result.uid);
      _service.saveToken();
    }

    loading = false;
  }

  Future<void> signUp(
      {required User user, Function? onFail, Function? onSuccess}) async {
    loading = true;
    await _service.signUp(user: user, onFail: onFail);
    _service.saveToken();
    loading = false;
  }

  void signOut() {
    _service.signOut();
    user = null;
    notifyListeners();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser() async {
    final result = await _service.loadCurrentUser();

    if (result != null) {
      findUser(result.uid);
      _service.saveToken();
    }
  }

  Future<void> findUser(String uid) async {
    final doc = await _service.getUser(uid);
    user = User.fromDocument(doc!);
    notifyListeners();
  }

  bool get adminEnabled => user != null && user!.email == "admin@admin.com";
}
