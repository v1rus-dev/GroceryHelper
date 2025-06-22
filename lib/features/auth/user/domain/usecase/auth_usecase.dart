import 'package:cookmatch/core/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:cookmatch/core/errors/errors.dart';

class AuthUsecase {
  final AuthRepository authRepository;

  AuthUsecase({required this.authRepository});

  Stream<User?> get authStateChanges => authRepository.authStateChanges;

  User? get currentUser => authRepository.currentUser;

  Future<Either<AppError, UserCredential>> signInWithGoogle() async {
    final result = await authRepository.signInWithGoogle();
    return result.fold(
      (e) => left(mapExceptionToAppError(e, StackTrace.current)),
      (userCredential) => right(userCredential),
    );
  }

  Future<Either<AppError, void>> signOut() async {
    final result = await authRepository.signOut();
    return result.fold(
      (e) => left(mapExceptionToAppError(e, StackTrace.current)),
      (r) => right(r),
    );
  }
}
