import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/viewModel/login_view_model.dart';
import 'package:provider/provider.dart';

import 'menu_header_widget.dart';
import 'menu_item_widget.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          MenuHeaderWidget(),
          const MenuItemWidget(iconData: Icons.home, title: 'Home', page: 0),
          const MenuItemWidget(
              iconData: Icons.list, title: 'Produtos', page: 1),
          Consumer<LoginViewModel>(
            builder: (_, userManager, __) {
              if (userManager.adminEnabled) {
                return Column(
                  children: const [
                    Divider(),
                    MenuItemWidget(
                      iconData: Icons.settings,
                      title: 'Usuários',
                      page: 4,
                    ),
                    MenuItemWidget(
                      iconData: Icons.settings,
                      title: 'Pedidos',
                      page: 5,
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          )
          // const MenuItem(
          //     iconData: Icons.playlist_add_check, title: 'Pedidos', page: 2),
          // const MenuItem(iconData: Icons.location_on, title: 'Lojas', page: 3),
        ],
      ),
    );
  }
}
