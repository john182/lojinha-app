import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/shared/widgets/menu/menu_widget.dart';
import 'package:loja_virtual/ui/viewModel/users_view_model.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuWidget(),
      appBar: AppBar(
        title: const Text('Usuários'),
        centerTitle: true,
      ),
      body: Consumer<UsersViewModel>(
        builder: (_, viewModel, __) {
          return AlphabetListScrollView(
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(
                  viewModel.users[index].name!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.black87),
                ),
                subtitle: Text(
                  viewModel.users[index].email,
                  style: const TextStyle(
                    color: Colors.black45,
                  ),
                ),
              );
            },
            highlightTextStyle:
                const TextStyle(color: Colors.white, fontSize: 20),
            indexedHeight: (index) => 80,
            strList: viewModel.names,
            showPreview: true,
          );
        },
      ),
    );
  }
}
