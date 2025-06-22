import 'package:cookmatch/core/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthUsecase {
  final AuthRepository authRepository;

  AuthUsecase({required this.authRepository});

  Stream<User?> get authStateChanges => authRepository.authStateChanges;

  User? get currentUser => authRepository.currentUser;

  Future<UserCredential> signInWithGoogle() =>
      authRepository.signInWithGoogle();
}
