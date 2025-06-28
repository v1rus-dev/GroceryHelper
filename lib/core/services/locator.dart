import 'package:groceryhelper/core/repositories/auth_repository.dart';
import 'package:groceryhelper/core/services/dialog_service.dart';
import 'package:groceryhelper/core/services/error_display_service.dart';
import 'package:groceryhelper/core/services/navigation_state_service.dart';
import 'package:groceryhelper/core/theme/bloc/theme_bloc.dart';
import 'package:groceryhelper/features/home/presentation/bloc/home_bloc.dart';
import 'package:groceryhelper/features/user/domain/usecase/auth_usecase.dart';
import 'package:groceryhelper/features/user/presentation/bloc/user_bloc.dart';
import 'package:groceryhelper/features/buskets/presentation/bloc/buskets_bloc.dart';
import 'package:groceryhelper/features/shopping_list/presentation/bloc/shopping_list_bloc.dart';
import 'package:get_it/get_it.dart';
import 'google_client_id_io.dart' if (dart.library.html) 'google_client_id_web.dart';

final locator = GetIt.instance;

Future<void> initServiceLocator() async {
  await initServices();
  await initRepositories();
  await initUsecases();
  await initBlocs();
}

Future<void> initBlocs() async {
  locator.registerFactory(() => HomeBloc());
  locator.registerFactory(() => BusketsBloc());
  locator.registerFactory(() => ShoppingListBloc());
  locator.registerFactory(() => UserBloc(authUsecase: locator()));
  locator.registerFactory(() => ThemeBloc());
}

Future<void> initRepositories() async {
  locator.registerSingleton(AuthRepository(googleClientId: getGoogleClientId()));
}

Future<void> initServices() async {
  locator.registerSingleton(DialogService.instance);
  locator.registerSingleton(ErrorDisplayService.instance);
  locator.registerSingleton(NavigationStateService.instance);
}

Future<void> initUsecases() async {
  locator.registerSingleton(AuthUsecase(authRepository: locator()));
}
