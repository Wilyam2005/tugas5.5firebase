import 'package:firebase_auth/firebase_auth.dart';

/// Simple AuthService wrapper around FirebaseAuth for register/login/logout.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Register using email & password. Throws FirebaseAuthException on failure.
  Future<UserCredential> register(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Login using email & password. Throws FirebaseAuthException on failure.
  Future<UserCredential> login(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Logout current user.
  Future<void> logout() async {
    await _auth.signOut();
  }

  /// Get current user.
  User? get currentUser => _auth.currentUser;
}
