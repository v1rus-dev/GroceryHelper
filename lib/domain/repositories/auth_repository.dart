import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Stream<User?> get authStateChanges;

  Stream<User?> get user;

  User? get currentUser;

  Future<Either<Exception, UserCredential>> signInWithGoogle();

  Future<Either<Exception, UserCredential>> signInWithApple();

  Future<Either<Exception, UserCredential>> signInWithEmailAndPassword(String email, String password);

  Future<Either<Exception, void>> signOut();
}
