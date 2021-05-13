import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/view/page/users/users_page_controller.dart';
import 'package:loja_virtual/view/shared/menu/menu.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: const Text('Usuários'),
        centerTitle: true,
      ),
      body: Consumer<UsersPageController>(
        builder: (_, controller, __) {
          return AlphabetListScrollView(
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(
                  controller.users[index].name!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.black87),
                ),
                subtitle: Text(
                  controller.users[index].email,
                  style: const TextStyle(
                    color: Colors.black45,
                  ),
                ),
              );
            },
            highlightTextStyle:
                const TextStyle(color: Colors.white, fontSize: 20),
            indexedHeight: (index) => 80,
            strList: controller.names,
            showPreview: true,
          );
        },
      ),
    );
  }
}
