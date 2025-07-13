import 'package:firebase_auth/firebase_auth.dart';
import 'package:groceryhelper/domain/repositories/auth_repository.dart';
import 'package:groceryhelper/domain/repositories/product_types_repository.dart';
import 'package:groceryhelper/domain/repositories/products_repository.dart';
import 'package:groceryhelper/domain/repositories/tags_repository.dart';
import 'package:groceryhelper/features/product_form/presentation/bloc/product_form_bloc.dart';
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
import 'package:groceryhelper/core/constants/app_constant_values.dart';
import 'package:groceryhelper/common_ui/theme/bloc/theme_bloc.dart';
import 'package:groceryhelper/features/home/presentation/bloc/home_bloc.dart';
import 'package:groceryhelper/features/user/domain/usecase/auth_usecase.dart';
import 'package:groceryhelper/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:groceryhelper/features/buskets/presentation/bloc/buskets_bloc.dart';
import 'package:groceryhelper/features/products_list/presentation/bloc/products_list_bloc.dart';
import 'package:groceryhelper/features/user/presentation/bloc/auth/auth_bloc.dart';
import 'package:groceryhelper/features/create_busket/presentation/bloc/create_busket_bloc.dart';
import 'package:get_it/get_it.dart';
import 'google_client_id_io.dart' if (dart.library.html) 'google_client_id_web.dart';

final locator = GetIt.instance;

Future<void> initServiceLocator(AppDatabase appDatabase) async {
  await initFirebase();
  await initDatabase(appDatabase);
  await initRepositories();
  await initServices();
  await initUsecases();
  await initFeatures();
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

/// Инициализация всех feature модулей
Future<void> initFeatures() async {
  await initHomeFeature();
  await initUserFeature();
  await initAuthFeature();
  await initRegisterFeature();
  await initCategoryTypeFeature();
  await initProductFormFeature();
  await initBusketsFeature();
  await initProductsListFeature();
  await initCreateBusketFeature();
  await initThemeFeature();
}

/// Инициализация Home feature
Future<void> initHomeFeature() async {
  locator.registerSingleton(HomeBloc());
}

/// Инициализация User feature
Future<void> initUserFeature() async {
  locator.registerSingleton(UserBloc());
}

/// Инициализация Auth feature
Future<void> initAuthFeature() async {
  locator.registerSingleton(AuthBloc(authUsecase: locator()));
}

/// Инициализация Register feature
Future<void> initRegisterFeature() async {
  locator.registerSingleton<RegisterRepository>(
    RegisterRepositoryFactory.create(useMock: AppConstantValues.isRegisterTestMode),
  );
  locator.registerSingleton<RegisterBloc>(RegisterBloc(registerRepository: locator()));
}

/// Инициализация CategoryType feature
Future<void> initCategoryTypeFeature() async {}

/// Инициализация ProductForm feature
Future<void> initProductFormFeature() async {
  locator.registerLazySingleton<ProductFormBloc>(
    () => ProductFormBloc(productTypesRepository: locator(), productsRepository: locator()),
  );
}

/// Инициализация Buskets feature
Future<void> initBusketsFeature() async {
  locator.registerSingleton(BusketsBloc());
}

/// Инициализация ProductsList feature
Future<void> initProductsListFeature() async {
  locator.registerSingleton(ProductsListBloc());
}

/// Инициализация CreateBusket feature
Future<void> initCreateBusketFeature() async {
  locator.registerSingleton<CreateBusketBloc>(CreateBusketBloc());
}

/// Инициализация Theme feature
Future<void> initThemeFeature() async {
  locator.registerSingleton(ThemeBloc());
}
