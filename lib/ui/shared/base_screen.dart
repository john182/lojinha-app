import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/page/home/home_page.dart';
import 'package:loja_virtual/ui/page/products/products_page.dart';
import 'package:loja_virtual/ui/page/users/users_page.dart';
import 'package:loja_virtual/ui/shared/menu/menu.dart';
import 'package:loja_virtual/ui/viewModel/login_view_model.dart';
import 'package:loja_virtual/ui/viewModel/page_manager.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => PageManage(pageController),
        child: Consumer<LoginViewModel>(
          builder: (_, userManager, __) {
            return PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                HomePage(),
                ProductsPage(),
                Scaffold(
                  drawer: Menu(),
                  appBar: AppBar(
                    title: const Text('Home3'),
                  ),
                ),
                Scaffold(
                  drawer: Menu(),
                  appBar: AppBar(
                    title: const Text('Home4'),
                  ),
                ),
                if (userManager.adminEnabled) ...[
                  UsersPage(),
                  Scaffold(
                    drawer: Menu(),
                    appBar: AppBar(
                      title: const Text('Pedidos'),
                    ),
                  ),
                ]
              ],
            );
          },
        ));
  }
}
