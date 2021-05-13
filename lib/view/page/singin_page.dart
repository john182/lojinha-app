import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/infra/validators.dart';
import 'package:loja_virtual/model/user.dart';
import 'package:loja_virtual/view/shared/view_util.dart';
import 'package:loja_virtual/view/viewModel/login_view_model.dart';
import 'package:provider/provider.dart';

class SingIn extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Entrar'),
          centerTitle: true,
        ),
        body: Center(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: Consumer<LoginViewModel>(
                builder: (_, viewModel, __) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: <Widget>[
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(hintText: 'E-mail'),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        enabled: !viewModel.loading,
                        validator: (email) {
                          if (!emailValid(email!)) {
                            return 'E-mail invalido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: passController,
                        decoration: const InputDecoration(hintText: 'Senha'),
                        autocorrect: false,
                        enabled: !viewModel.loading,
                        obscureText: true,
                        validator: (pass) {
                          if (pass!.isEmpty || pass.length < 6) {
                            return 'Senha invalida';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Esqueci minha senha'),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: viewModel.loading
                              ? null
                              : () {
                                  login(viewModel, context);
                                },
                          child: viewModel.loading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  ),
                                )
                              : const Text('Entrar')),
                      const SizedBox(height: 32),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/singup');
                        },
                        child: const Text('New user? create acount'),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login(LoginViewModel viewModel, BuildContext context) {
    if (formKey.currentState!.validate()) {
      viewModel.signIn(
          user:
              User(email: emailController.text, password: passController.text),
          onFail: (e) {
            ViewUtil.showInSnackBar(e.toString(), scaffoldKey);
          },
          onSuccess: () {
            Navigator.of(context).pop();
          });
    }
  }
}
