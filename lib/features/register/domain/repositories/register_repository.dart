import 'package:dartz/dartz.dart';
import 'package:groceryhelper/core/errors/errors.dart';
import 'package:groceryhelper/features/register/domain/entities/register_request.dart';

abstract class RegisterRepository {
  Future<Either<AppError, dynamic>> registerWithEmailAndPassword(RegisterRequest request);
  Future<Either<AppError, bool>> isEmailAlreadyInUse(String email);
}
