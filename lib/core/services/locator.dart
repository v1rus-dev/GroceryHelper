import 'package:flutter/foundation.dart';
import 'package:groceryhelper/core/repositories/auth_repository.dart';
import 'package:groceryhelper/features/user/domain/usecase/auth_usecase.dart';
import 'package:groceryhelper/features/user/presentation/bloc/user_bloc.dart';
import 'package:groceryhelper/features/recipes/presentation/bloc/recipes_bloc.dart';
import 'package:groceryhelper/features/shopping_list/presentation/bloc/shopping_list_bloc.dart';
import 'package:get_it/get_it.dart';
import 'google_client_id_io.dart' if (dart.library.html) 'google_client_id_web.dart';

final locator = GetIt.instance;

Future<void> initServiceLocator() async {
  await initRepositories();
  await initUsecases();
  await initBlocs();
}

Future<void> initBlocs() async {
  locator.registerFactory(() => RecipesBloc());
  locator.registerFactory(() => ShoppingListBloc());

  locator.registerFactory(() => UserBloc(authUsecase: locator()));
}

Future<void> initRepositories() async {
  locator.registerSingleton(AuthRepository(googleClientId: getGoogleClientId()));
}

Future<void> initUsecases() async {
  locator.registerSingleton(AuthUsecase(authRepository: locator()));
}
