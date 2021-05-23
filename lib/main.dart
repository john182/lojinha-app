import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/infra/routes.dart';
import 'package:loja_virtual/ui/viewModel/address_view_model.dart';
import 'package:loja_virtual/ui/viewModel/cart_view_model.dart';
import 'package:loja_virtual/ui/viewModel/home_view_model.dart';
import 'package:loja_virtual/ui/viewModel/login_view_model.dart';
import 'package:loja_virtual/ui/viewModel/product_view_model.dart';
import 'package:loja_virtual/ui/viewModel/products_view_model.dart';
import 'package:loja_virtual/ui/viewModel/users_view_model.dart';
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
          create: (_) => HomeViewModel(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => AddressViewModel(),
        ),
        ChangeNotifierProxyProvider<LoginViewModel, CartViewModel>(
          create: (_) => CartViewModel(),
          lazy: false,
          update: (_, loginViewModel, cartViewModel) =>
              cartViewModel!..updateUser(loginViewModel.user),
        ),
        ChangeNotifierProxyProvider<LoginViewModel, UsersViewModel>(
          create: (_) => UsersViewModel(),
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
