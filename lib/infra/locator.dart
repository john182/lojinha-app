import 'package:get_it/get_it.dart';
import 'package:loja_virtual/service/adddress_service.dart';
import 'package:loja_virtual/service/home_service.dart';
import 'package:loja_virtual/service/product_service.dart';
import 'package:loja_virtual/service/user_service.dart';
import 'package:loja_virtual/ui/viewModel/login_view_model.dart';

GetIt locator = GetIt.instance;
// factory para injetar classes
void setupLocator() {
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => ProductService());
  locator.registerLazySingleton(() => HomeService());
  locator.registerLazySingleton(() => AddressService());

  locator.registerFactory(() => LoginViewModel());
}
