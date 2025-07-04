import 'package:firebase_auth/firebase_auth.dart';
import 'package:groceryhelper/core/repositories/auth_repository.dart';
import 'package:groceryhelper/core/services/error_display_service.dart';
import 'package:groceryhelper/core/services/navigation_state_service.dart';
import 'package:groceryhelper/core/constants/app_constant_values.dart';
import 'package:groceryhelper/core/theme/bloc/theme_bloc.dart';
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

Future<void> initServiceLocator() async {
  await initFirebase();
  await initServices();
  await initRepositories();
  await initUsecases();
  await initBlocs();
}

Future<void> initFirebase() async {
  locator.registerSingleton(FirebaseAuth.instance);
}

Future<void> initBlocs() async {
  locator.registerSingleton(HomeBloc());
  locator.registerSingleton(BusketsBloc());
  locator.registerSingleton(ProductsListBloc());
  locator.registerSingleton(UserBloc());
  locator.registerSingleton(AuthBloc(authUsecase: locator()));
  locator.registerSingleton(ThemeBloc());
}

Future<void> initRepositories() async {
  locator.registerSingleton(AuthRepository(firebaseAuth: locator(), googleClientId: getGoogleClientId()));
  locator.registerFactoryAsync<RegisterRepository>(
    () => RegisterRepositoryFactory.create(useMock: AppConstantValues.isRegisterTestMode),
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
