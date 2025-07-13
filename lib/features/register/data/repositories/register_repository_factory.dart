import 'package:firebase_auth/firebase_auth.dart';
import 'package:groceryhelper/features/register/domain/repositories/register_repository.dart';
import 'package:groceryhelper/infrastructure/services/locator.dart';
import 'package:groceryhelper/features/register/data/repositories/register_repository_mock.dart';
import 'package:groceryhelper/features/register/data/repositories/register_repository_impl.dart';

class RegisterRepositoryFactory {
  static RegisterRepository create({bool useMock = true}) {
    if (useMock) {
      return RegisterRepositoryMock();
    } else {
      final firebaseAuth = locator<FirebaseAuth>();
      return RegisterRepositoryImpl(firebaseAuth: firebaseAuth);
    }
  }
}
