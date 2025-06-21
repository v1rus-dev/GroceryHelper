import 'package:cookmatch/features/recipes/presentation/bloc/recipes_bloc.dart';
import 'package:cookmatch/features/shopping_list/presentation/bloc/shopping_list_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> initServiceLocator() async {
  locator.registerFactory(() => RecipesBloc());
  locator.registerFactory(() => ShoppingListBloc());
}
