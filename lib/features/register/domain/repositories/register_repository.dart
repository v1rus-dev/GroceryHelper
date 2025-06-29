import 'package:dartz/dartz.dart';
import 'package:groceryhelper/features/register/domain/entities/register_request.dart';

abstract class RegisterRepository {
  Future<Either<Exception, dynamic>> registerWithEmailAndPassword(RegisterRequest request);
  Future<Either<Exception, bool>> isEmailAlreadyInUse(String email);
}
