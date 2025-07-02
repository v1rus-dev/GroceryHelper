import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:groceryhelper/core/services/talker_service.dart';
import 'package:groceryhelper/core/errors/errors.dart';
import 'package:groceryhelper/features/register/domain/entities/register_request.dart';
import 'package:groceryhelper/features/register/domain/repositories/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final FirebaseAuth _firebaseAuth;

  RegisterRepositoryImpl({required FirebaseAuth firebaseAuth}) : _firebaseAuth = firebaseAuth;

  @override
  Future<Either<AppError, dynamic>> registerWithEmailAndPassword(RegisterRequest request) async {
    try {
      TalkerService.log('Creating user with email: ${request.email}');

      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );

      // Обновляем displayName пользователя
      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(request.username);
        TalkerService.log('Updated display name for user: ${request.username}');
      }

      TalkerService.log('Successfully registered user: ${userCredential.user?.email}');
      return right(userCredential);
    } on FirebaseAuthException catch (e) {
      TalkerService.error('Firebase Auth Exception during registration', e);
      String errorMessage;

      switch (e.code) {
        case 'weak-password':
          errorMessage = 'Пароль слишком слабый';
          break;
        case 'email-already-in-use':
          errorMessage = 'Пользователь с такой почтой уже существует';
          break;
        case 'invalid-email':
          errorMessage = 'Неверный формат почты';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Регистрация с почтой и паролем отключена';
          break;
        default:
          errorMessage = 'Ошибка при регистрации: ${e.message}';
      }

      return left(AppError(message: errorMessage, type: AppErrorType.dialog, cause: e));
    } catch (e) {
      TalkerService.error('Unexpected error during registration', e);
      return left(AppError(message: 'Неожиданная ошибка при регистрации', type: AppErrorType.dialog, cause: e));
    }
  }

  @override
  Future<Either<AppError, bool>> isEmailAlreadyInUse(String email) async {
    try {
      TalkerService.log('Checking if email is already in use: $email');

      final methods = await _firebaseAuth.fetchSignInMethodsForEmail(email);
      final isInUse = methods.isNotEmpty;

      TalkerService.log('Email $email is ${isInUse ? 'already in use' : 'available'}');
      return right(isInUse);
    } on FirebaseAuthException catch (e) {
      TalkerService.error('Firebase Auth Exception while checking email', e);
      return left(AppError(message: 'Ошибка при проверке почты: ${e.message}', type: AppErrorType.dialog, cause: e));
    } catch (e) {
      TalkerService.error('Unexpected error while checking email', e);
      return left(AppError(message: 'Ошибка при проверке почты', type: AppErrorType.dialog, cause: e));
    }
  }
}
