import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthStatusService {
  /// Проверяет, авторизован ли пользователь
  Future<bool> isUserAuthenticated();

  /// Получает текущего пользователя
  User? getCurrentUser();

  /// Слушает изменения статуса авторизации
  Stream<User?> get authStateChanges;
}

class FirebaseAuthStatusService implements AuthStatusService {
  final FirebaseAuth _auth;

  FirebaseAuthStatusService({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  @override
  Future<bool> isUserAuthenticated() async {
    return _auth.currentUser != null;
  }

  @override
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  @override
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
