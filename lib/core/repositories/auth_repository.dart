import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      _googleSignIn =
          googleSignIn ??
          (kIsWeb
              ? GoogleSignIn(
                  clientId:
                      "806843890541-pir2l3fnq81rhop1pvfivac1n4m8t1m7.apps.googleusercontent.com",
                )
              : GoogleSignIn());

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // Пользователь отменил вход
        throw Exception('Sign in aborted by user');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      // Ошибки Firebase Auth
      print('FirebaseAuthException: ${e.code} — ${e.message}');
      rethrow;
    } on FirebaseException catch (e) {
      // Общие Firebase ошибки
      print('FirebaseException: ${e.code} — ${e.message}');
      rethrow;
    } catch (e, st) {
      // Все остальные ошибки (в том числе platform/web)
      print('Unknown error: $e\n$st');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
