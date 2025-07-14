import 'package:get_it/get_it.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'domain/usecase/auth_usecase.dart';

void registerAuthDependencies(GetIt locator) {
  locator.registerSingleton<AuthBloc>(AuthBloc(authUsecase: locator<AuthUsecase>()));
}
