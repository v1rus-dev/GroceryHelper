import 'package:flutter/foundation.dart';
import 'package:groceryhelper/core/repositories/auth_repository.dart';
import 'package:groceryhelper/features/auth/user/domain/usecase/auth_usecase.dart';
import 'package:groceryhelper/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:groceryhelper/features/auth/user/presentation/bloc/user_bloc.dart';
import 'package:groceryhelper/features/recipes/presentation/bloc/recipes_bloc.dart';
import 'package:groceryhelper/features/shopping_list/presentation/bloc/shopping_list_bloc.dart';
import 'package:get_it/get_it.dart';
import 'dart:html' as html;

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
  locator.registerFactory(() => LoginBloc());
}

Future<void> initRepositories() async {
  locator.registerSingleton(
    AuthRepository(googleClientId: _getGoogleClientId()),
  );
}

Future<void> initUsecases() async {
  locator.registerSingleton(AuthUsecase(authRepository: locator()));
}

String? _getGoogleClientId() {
  if (kIsWeb) {
    final meta =
        html.document.querySelector('meta[name="google-signin-client_id"]')
            as html.MetaElement?;
    return meta?.content;
  } else {
    return null;
  }
}
