import 'package:get_it/get_it.dart';
import 'bloc/theme_bloc.dart';

void registerThemeDependencies(GetIt locator) {
  locator.registerSingleton<ThemeBloc>(ThemeBloc());
}
