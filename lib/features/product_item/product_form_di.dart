import 'package:get_it/get_it.dart';
import 'presentation/bloc/product_form_bloc.dart';
import 'package:groceryhelper/domain/repositories/product_types_repository.dart';
import 'package:groceryhelper/domain/repositories/products_repository.dart';

void registerProductFormDependencies(GetIt locator) {
  locator.registerLazySingleton<ProductItemBloc>(
    () => ProductItemBloc(
      productTypesRepository: locator<ProductTypesRepository>(),
      productsRepository: locator<ProductsRepository>(),
    ),
  );
}
