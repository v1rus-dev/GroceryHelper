import 'package:get_it/get_it.dart';
import 'presentation/bloc/user/user_bloc.dart';

void registerUserDependencies(GetIt locator) {
  locator.registerSingleton<UserBloc>(UserBloc());
}
