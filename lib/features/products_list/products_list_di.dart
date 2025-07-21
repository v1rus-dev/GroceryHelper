import 'package:get_it/get_it.dart';
import 'package:groceryhelper/features/products_list/domain/usecases/get_products_list_usecase.dart';
import 'package:groceryhelper/features/products_list/domain/usecases/observe_products_usecase.dart';
import 'package:groceryhelper/features/products_list/domain/usecases/seartch_products_usecase.dart';
import 'package:groceryhelper/features/products_list/domain/usecases/remove_product_usecase.dart';
import 'presentation/bloc/products_list_bloc.dart';

void registerProductsListDependencies(GetIt locator) {
  locator.registerSingleton<GetProductsListUsecase>(GetProductsListUsecase(locator()));
  locator.registerSingleton<ObserveProductsUsecase>(ObserveProductsUsecase(locator()));
  locator.registerSingleton<SearchProductsUsecase>(SearchProductsUsecase(locator()));
  locator.registerSingleton<RemoveProductUsecase>(RemoveProductUsecase(locator()));
  locator.registerSingleton<ProductsListBloc>(
    ProductsListBloc(
      getProductsListUsecase: locator(),
      observeProductsUsecase: locator(),
      searchProductsUsecase: locator(),
      removeProductUsecase: locator(),
    ),
  );
}
