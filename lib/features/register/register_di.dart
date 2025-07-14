part of 'register.dart';

Future<void> registerRegisterDependencies(GetIt locator) async {
  final repository = await RegisterRepositoryFactory.create(useMock: AppConstantValues.isRegisterTestMode);
  locator.registerSingleton<RegisterRepository>(repository);
  locator.registerSingleton<RegisterBloc>(RegisterBloc(registerRepository: locator()));
}
