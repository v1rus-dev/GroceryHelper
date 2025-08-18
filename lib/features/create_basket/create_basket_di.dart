import 'package:get_it/get_it.dart';
import 'presentation/bloc/create_busket_bloc.dart';

void registerCreateBasketDependencies(GetIt locator) {
  locator.registerFactory<CreateBusketBloc>(() => CreateBusketBloc());
}
