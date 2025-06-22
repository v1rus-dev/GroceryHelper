import 'package:cookmatch/core/repositories/auth_repository.dart';
import 'package:cookmatch/features/auth/user/domain/usecase/auth_usecase.dart';
import 'package:cookmatch/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:cookmatch/features/auth/user/presentation/bloc/user_bloc.dart';
import 'package:cookmatch/features/recipes/presentation/bloc/recipes_bloc.dart';
import 'package:cookmatch/features/shopping_list/presentation/bloc/shopping_list_bloc.dart';
import 'package:get_it/get_it.dart';

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
  locator.registerSingleton(AuthRepository());
}

Future<void> initUsecases() async {
  locator.registerSingleton(AuthUsecase(authRepository: locator()));
}
