import 'package:get_it/get_it.dart';
import 'presentation/bloc/products_list_bloc.dart';

void registerProductsListDependencies(GetIt locator) {
  locator.registerSingleton<ProductsListBloc>(ProductsListBloc());
}
