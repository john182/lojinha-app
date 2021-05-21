import 'package:flutter/material.dart';
import 'package:loja_virtual/model/product.dart';
import 'package:loja_virtual/ui/page/adress/address_page.dart';
import 'package:loja_virtual/ui/page/cart/cart_page.dart';
import 'package:loja_virtual/ui/page/edit_product/edit_product_page.dart';
import 'package:loja_virtual/ui/page/product/product_page.dart';
import 'package:loja_virtual/ui/page/singin_page.dart';
import 'package:loja_virtual/ui/page/singup_page.dart';
import 'package:loja_virtual/ui/shared/base_screen.dart';

class Routes {
  static Route<dynamic> definerRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => BaseScreen());
      case '/singup':
        return MaterialPageRoute(builder: (_) => SingUp());
      case '/singin':
        return MaterialPageRoute(builder: (_) => SingIn());
      case '/cart':
        return MaterialPageRoute(builder: (_) => CartPage());
      case '/address':
        return MaterialPageRoute(builder: (_) => const AdrressPage());
      case '/product':
        return MaterialPageRoute(
            builder: (_) => ProductPage(settings.arguments! as Product));
      case '/edit_product':
        return MaterialPageRoute(
            builder: (_) => EditProduct(settings.arguments! as Product));
      default:
        return MaterialPageRoute(builder: (_) => BaseScreen());
    }
  }
}
