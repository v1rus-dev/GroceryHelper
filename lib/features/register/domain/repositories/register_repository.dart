part of '../../register.dart';

abstract class RegisterRepository {
  Future<Either<AppError, dynamic>> registerWithEmailAndPassword(RegisterRequest request);
  Future<Either<AppError, bool>> isEmailAlreadyInUse(String email);
}
