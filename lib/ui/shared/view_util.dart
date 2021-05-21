import 'package:flutter/material.dart';

class ViewUtil {
  static ViewUtil? _instance;

  factory ViewUtil() => _instance ??= ViewUtil();

  /// Mostra uma snackbar com uma mensagem
  static showInSnackBar(
      String value, GlobalKey<ScaffoldMessengerState> scaffoldKey) {
    scaffoldKey.currentState?.showSnackBar(SnackBar(
      content: Text(value),
      backgroundColor: Colors.red,
    ));
  }
}
