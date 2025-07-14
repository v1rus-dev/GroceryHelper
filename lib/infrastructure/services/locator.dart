import 'package:firebase_auth/firebase_auth.dart';
import 'package:groceryhelper/domain/repositories/auth_repository.dart';
import 'package:groceryhelper/domain/repositories/product_types_repository.dart';
import 'package:groceryhelper/domain/repositories/products_repository.dart';
import 'package:groceryhelper/domain/repositories/tags_repository.dart';
import 'package:groceryhelper/features/baskets/baskets.dart';
import 'package:groceryhelper/features/register/register.dart';
import 'package:groceryhelper/infrastructure/database/app_database.dart';
import 'package:groceryhelper/infrastructure/database/repositories/product_types_repository_impl.dart';
import 'package:groceryhelper/infrastructure/database/repositories/products_repository_impl.dart';
import 'package:groceryhelper/infrastructure/database/repositories/tags_repository_impl.dart';
import 'package:groceryhelper/infrastructure/datasources/local/local_product_datasource.dart';
import 'package:groceryhelper/infrastructure/datasources/local/local_product_type_datasource.dart';
import 'package:groceryhelper/infrastructure/datasources/local/local_tag_datasource.dart';
import 'package:groceryhelper/infrastructure/datasources/network/network_product_datasource.dart';
import 'package:groceryhelper/infrastructure/datasources/network/network_tag_datasource.dart';
import 'package:groceryhelper/infrastructure/datasources/network/network_product_type_datasource.dart';
import 'package:groceryhelper/infrastructure/di/database_di.dart';
import 'package:groceryhelper/infrastructure/firebase/auth_repository_impl.dart';
import 'package:groceryhelper/infrastructure/services/auth_status_service.dart';
import 'package:groceryhelper/infrastructure/services/error_display_service.dart';
import 'package:groceryhelper/infrastructure/services/navigation_state_service.dart';
import 'package:groceryhelper/features/home/home_di.dart';
import 'package:groceryhelper/features/user/domain/usecase/auth_usecase.dart';
import 'package:groceryhelper/features/user/user_di.dart';
import 'package:groceryhelper/features/user/auth_di.dart';
import 'package:groceryhelper/features/product_item/product_form_di.dart';
import 'package:groceryhelper/features/products_list/products_list_di.dart';
import 'package:groceryhelper/features/create_basket/create_basket_di.dart';
import 'package:groceryhelper/shared_ui/theme/theme_di.dart';
import 'package:get_it/get_it.dart';
import 'google_client_id_io.dart' if (dart.library.html) 'google_client_id_web.dart';

final locator = GetIt.instance;

Future<void> initServiceLocator(AppDatabase appDatabase) async {
  await initFirebase();
  await initDatabase(appDatabase);
  await initRepositories();
  await initServices();
  await initUsecases();
  // Регистрация feature зависимостей
  registerHomeDependencies(locator);
  registerUserDependencies(locator);
  registerAuthDependencies(locator);
  await registerRegisterDependencies(locator);
  registerProductFormDependencies(locator);
  registerBasketsDependencies(locator);
  registerProductsListDependencies(locator);
  registerCreateBasketDependencies(locator);
  registerThemeDependencies(locator);
}

Future<void> initFirebase() async {
  locator.registerSingleton(FirebaseAuth.instance);
  locator.registerSingleton(AuthStatusService.instance);
}

Future<void> initDatabase(AppDatabase appDatabase) async {
  DatabaseDI.register(appDatabase);
}

Future<void> initServices() async {
  locator.registerSingleton(ErrorDisplayService.instance);
  locator.registerSingleton(NavigationStateService.instance);
}

Future<void> initRepositories() async {
  locator.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(firebaseAuth: locator(), googleClientId: getGoogleClientId()),
  );
  locator.registerSingleton<ProductsRepository>(
    ProductsRepositoryImpl(
      localProductDatasource: locator<LocalProductDatasource>(),
      networkProductDatasource: locator<NetworkProductDatasource>(),
      authStatusService: locator<AuthStatusService>(),
    ),
  );

  locator.registerSingleton<TagsRepository>(
    TagsRepositoryImpl(
      localTagDatasource: locator<LocalTagDatasource>(),
      networkTagDatasource: locator<NetworkTagDatasource>(),
      authStatusService: locator<AuthStatusService>(),
    ),
  );

  locator.registerSingleton<ProductTypesRepository>(
    ProductTypesRepositoryImpl(
      localDatasource: locator<LocalProductTypeDatasource>(),
      networkDatasource: locator<NetworkProductTypeDatasource>(),
    ),
  );
}

Future<void> initUsecases() async {
  locator.registerSingleton(AuthUsecase(authRepository: locator()));
}
