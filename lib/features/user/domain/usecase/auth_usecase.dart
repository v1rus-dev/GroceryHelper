import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:groceryhelper/core/errors/errors.dart';
import 'package:groceryhelper/domain/repositories/auth_repository.dart';

class AuthUsecase {
  final AuthRepository authRepository;

  AuthUsecase({required this.authRepository});

  Stream<User?> get authStateChanges => authRepository.authStateChanges;

  Stream<User?> get user => authRepository.user;

  User? get currentUser => authRepository.currentUser;

  Future<Either<AppError, UserCredential>> signInWithGoogle() async {
    final result = await authRepository.signInWithGoogle();
    return result.fold(
      (e) => left(mapExceptionToAppError(e, StackTrace.current)),
      (userCredential) => right(userCredential),
    );
  }

  Future<Either<AppError, UserCredential>> signInWithApple() async {
    final result = await authRepository.signInWithApple();
    return result.fold(
      (e) => left(mapExceptionToAppError(e, StackTrace.current)),
      (userCredential) => right(userCredential),
    );
  }

  Future<Either<AppError, UserCredential>> signInWithEmailAndPassword(String email, String password) async {
    final result = await authRepository.signInWithEmailAndPassword(email, password);
    return result.fold(
      (e) => left(mapExceptionToAppError(e, StackTrace.current)),
      (userCredential) => right(userCredential),
    );
  }

  Future<Either<AppError, void>> signOut() async {
    final result = await authRepository.signOut();
    return result.fold((e) => left(mapExceptionToAppError(e, StackTrace.current)), (r) => right(r));
  }
}
