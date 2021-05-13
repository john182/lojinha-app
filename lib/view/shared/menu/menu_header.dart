import 'package:flutter/material.dart';
import 'package:loja_virtual/view/viewModel/login_view_model.dart';
import 'package:loja_virtual/view/viewModel/page_manager.dart';
import 'package:provider/provider.dart';

class MenuHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 180,
      child: Consumer<LoginViewModel>(
        builder: (_, viewModel, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text(
                'Loja do\nDaniel',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Olá, ${viewModel.user?.name ?? ''}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (viewModel.isLoggedIn) {
                    context.read<PageManage>().setPage(0);
                    viewModel.signOut();
                  } else {
                    Navigator.of(context).pushNamed('/singin');
                  }
                },
                child: Text(
                  viewModel.isLoggedIn ? 'Sair' : 'Entrar',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
