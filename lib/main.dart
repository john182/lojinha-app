import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/infra/routes.dart';
import 'package:loja_virtual/view/page/home/home_page_controller.dart';
import 'package:loja_virtual/view/page/users/users_page_controller.dart';
import 'package:loja_virtual/view/viewModel/cart_view_model.dart';
import 'package:loja_virtual/view/viewModel/login_view_model.dart';
import 'package:loja_virtual/view/viewModel/product_view_model.dart';
import 'package:loja_virtual/view/viewModel/products_view_model.dart';
import 'package:provider/provider.dart';

import 'infra/locator.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(),
          lazy: false,
        ),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(
          create: (_) => ProductsViewModel(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomePageController(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<LoginViewModel, CartViewModel>(
          create: (_) => CartViewModel(),
          lazy: false,
          update: (_, loginViewModel, cartViewModel) =>
              cartViewModel!..updateUser(loginViewModel.user),
        ),
        ChangeNotifierProxyProvider<LoginViewModel, UsersPageController>(
          create: (_) => UsersPageController(),
          lazy: false,
          update: (_, loginController, usersController) =>
              usersController!..updateUser(loginController.adminEnabled),
        ),
      ],
      child: MaterialApp(
        title: 'Loja',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        initialRoute: '/',
        onGenerateRoute: Routes.definerRoute,
      ),
    );
  }
}
