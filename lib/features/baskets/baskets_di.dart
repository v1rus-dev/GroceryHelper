part of 'baskets.dart';

void registerBasketsDependencies(GetIt locator) {
  locator.registerSingleton<BusketsBloc>(BusketsBloc());
}
