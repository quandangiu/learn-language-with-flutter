// ...existing code...
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  // Đăng nhập bằng Google (web dùng signInWithPopup để tránh People API)
  Future<UserCredential?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        final provider = GoogleAuthProvider();
        // Nếu cần scopes: provider.addScope('email'); // thường không cần
        final userCred = await _auth.signInWithPopup(provider);
        debugPrint('Google sign-in (web) success: ${userCred.user?.uid}');
        return userCred;
      }

      // mobile flow (android/ios)
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // user cancelled

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCred = await _auth.signInWithCredential(credential);
      debugPrint('Google sign-in (mobile) success: ${userCred.user?.uid}');
      return userCred;
    } on FirebaseAuthException catch (e, st) {
      debugPrint('FirebaseAuthException: ${e.code} ${e.message}');
      debugPrint('$st');
      rethrow;
    } catch (e, st) {
      debugPrint('signInWithGoogle failed: $e');
      debugPrint('$st');
      rethrow;
    }
  }

  Future<void> signOut() async {
    if (kIsWeb) {
      await _auth.signOut();
    } else {
      await _googleSignIn.signOut();
      await _auth.signOut();
    }
  }

  User? get currentUser => _auth.currentUser;
}
// ...existing code...