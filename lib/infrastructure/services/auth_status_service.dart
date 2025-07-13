import 'package:firebase_auth/firebase_auth.dart';

class AuthStatusService {
  static final AuthStatusService _instance = AuthStatusService._internal();
  factory AuthStatusService() => _instance;
  final FirebaseAuth _auth;

  AuthStatusService._internal({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  static AuthStatusService get instance => _instance;

  Future<bool> isUserAuthenticated() async {
    return _auth.currentUser != null;
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
