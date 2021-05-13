import 'package:flutter/material.dart';
import 'package:loja_virtual/infra/validators.dart';
import 'package:loja_virtual/model/user.dart';
import 'package:loja_virtual/view/shared/view_util.dart';
import 'package:loja_virtual/view/viewModel/login_view_model.dart';
import 'package:provider/provider.dart';

class SingUp extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  final User user = User(email: '', password: '');

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<LoginViewModel>(context);

    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Criar Conta'),
          centerTitle: true,
        ),
        body: Center(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                children: <Widget>[
                  TextFormField(
                    decoration:
                        const InputDecoration(hintText: 'Nome Completo'),
                    onSaved: (name) => user.name = name ?? '',
                    validator: (name) {
                      if (name!.isEmpty) {
                        return 'Campo obrigatório';
                      } else if (name.trim().split(' ').length <= 1) {
                        return 'Preencha seu Nome completo';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'E-mail'),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (email) => user.email = email ?? '',
                    validator: (email) {
                      if (email?.isEmpty ?? true) {
                        return 'Campo obrigatório';
                      } else if (!emailValid(email!)) {
                        return 'E-mail inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Senha'),
                    obscureText: true,
                    onSaved: (pass) => user.password = pass ?? '',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(hintText: 'Repita a Senha'),
                    onSaved: (pass) => user.confirmPassword = pass ?? '',
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: viewModel.loading
                          ? null
                          : () {
                              singup(viewModel, context);
                            },
                      child: viewModel.loading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : const Text('Criar Conta'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void singup(LoginViewModel viewModel, BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      if (user.password != user.confirmPassword) {
        ViewUtil.showInSnackBar('Senhas não coincidem!', scaffoldKey);
        return;
      }

      viewModel.signUp(
          user: user,
          onSuccess: () {
            Navigator.of(context).pop();
          },
          onFail: (e) {
            ViewUtil.showInSnackBar('Falha ao cadastrar: $e', scaffoldKey);
          });
    }
  }
}
