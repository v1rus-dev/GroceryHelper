part of '../../register.dart';

class RegisterRepositoryFactory {
  static Future<RegisterRepository> create({bool useMock = true}) async {
    if (useMock) {
      return RegisterRepositoryMock();
    } else {
      final firebaseAuth = locator<FirebaseAuth>();
      return RegisterRepositoryImpl(firebaseAuth: firebaseAuth);
    }
  }
}
