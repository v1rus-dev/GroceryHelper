import 'package:get_it/get_it.dart';
import 'presentation/bloc/home_bloc.dart';

void registerHomeDependencies(GetIt locator) {
  locator.registerSingleton<HomeBloc>(HomeBloc());
}
