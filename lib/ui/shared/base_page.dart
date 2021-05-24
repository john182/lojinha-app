import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/page/home/home_page.dart';
import 'package:loja_virtual/ui/page/products/products_page.dart';
import 'package:loja_virtual/ui/page/users/users_page.dart';
import 'package:loja_virtual/ui/shared/widgets/menu/menu_widget.dart';
import 'package:loja_virtual/ui/viewModel/login_view_model.dart';
import 'package:loja_virtual/ui/viewModel/page_view_model.dart';
import 'package:provider/provider.dart';

class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => PageViewModel(pageController),
        child: Consumer<LoginViewModel>(
          builder: (_, userManager, __) {
            return PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                HomePage(),
                ProductsPage(),
                Scaffold(
                  drawer: MenuWidget(),
                  appBar: AppBar(
                    title: const Text('Home3'),
                  ),
                ),
                Scaffold(
                  drawer: MenuWidget(),
                  appBar: AppBar(
                    title: const Text('Home4'),
                  ),
                ),
                if (userManager.adminEnabled) ...[
                  UsersPage(),
                  Scaffold(
                    drawer: MenuWidget(),
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
