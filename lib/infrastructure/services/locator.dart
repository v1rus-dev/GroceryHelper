import 'package:firebase_auth/firebase_auth.dart';
import 'package:groceryhelper/domain/repositories/auth_repository.dart';
import 'package:groceryhelper/features/category_type/data/datasource/local_product_type_datasource.dart';
import 'package:groceryhelper/features/category_type/data/repository_impl/product_type_repository_impl.dart';
import 'package:groceryhelper/features/category_type/domain/repository/product_type_repository.dart';
import 'package:groceryhelper/infrastructure/database/app_database.dart';
import 'package:groceryhelper/infrastructure/database/database_initializer.dart';
import 'package:groceryhelper/infrastructure/firebase/auth_repository_impl.dart';
import 'package:groceryhelper/infrastructure/services/error_display_service.dart';
import 'package:groceryhelper/infrastructure/services/navigation_state_service.dart';
import 'package:groceryhelper/infrastructure/services/database_service.dart';
import 'package:groceryhelper/core/constants/app_constant_values.dart';
import 'package:groceryhelper/common_ui/theme/bloc/theme_bloc.dart';
import 'package:groceryhelper/features/home/presentation/bloc/home_bloc.dart';
import 'package:groceryhelper/features/register/register.dart';
import 'package:groceryhelper/features/user/domain/usecase/auth_usecase.dart';
import 'package:groceryhelper/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:groceryhelper/features/buskets/presentation/bloc/buskets_bloc.dart';
import 'package:groceryhelper/features/products_list/presentation/bloc/products_list_bloc.dart';
import 'package:groceryhelper/features/user/presentation/bloc/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'google_client_id_io.dart' if (dart.library.html) 'google_client_id_web.dart';

final locator = GetIt.instance;

Future<void> initServiceLocator(AppDatabase appDatabase) async {
  await initFirebase();
  await initDatabase(appDatabase);
  await initDatasources();
  await initServices();
  await initRepositories();
  await initUsecases();
  await initBlocs();
}

Future<void> initFirebase() async {
  locator.registerSingleton(FirebaseAuth.instance);
}

Future<void> initDatabase(AppDatabase appDatabase) async {
  locator.registerSingleton(appDatabase);
  locator.registerSingleton(DatabaseService(database: appDatabase));
}

Future<void> initBlocs() async {
  locator.registerSingleton(HomeBloc());
  locator.registerSingleton(BusketsBloc());
  locator.registerSingleton(ProductsListBloc());
  locator.registerSingleton(UserBloc());
  locator.registerSingleton(AuthBloc(authUsecase: locator()));
  locator.registerSingleton(ThemeBloc());
}

Future<void> initDatasources() async {
  locator.registerSingleton(LocalProductTypeDatasource(appDatabase: locator()));
}

Future<void> initRepositories() async {
  locator.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(firebaseAuth: locator(), googleClientId: getGoogleClientId()),
  );
  locator.registerFactoryAsync<RegisterRepository>(
    () => RegisterRepositoryFactory.create(useMock: AppConstantValues.isRegisterTestMode),
  );
  locator.registerFactoryAsync<ProductTypeRepository>(
    () => Future.value(ProductTypeRepositoryImpl(localProductTypeDatasource: locator())),
  );
}

Future<void> initServices() async {
  locator.registerSingleton(ErrorDisplayService.instance);
  locator.registerSingleton(NavigationStateService.instance);
}

Future<void> initUsecases() async {
  locator.registerSingleton(AuthUsecase(authRepository: locator()));
  // RegisterUsecase будет создаваться локально в RegisterBloc
}
