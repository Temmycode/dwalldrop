import 'package:dwalldrop/authentication/enums/auth_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthClient {
  static String error = '';
  // IS LOGGED IN FUNCTION
  bool get isLoggedIn => userId != null ? true : false;
  // THE USER EMAIL
  String? get email => FirebaseAuth.instance.currentUser?.email;
  // THE USER ID
  String? get userId => FirebaseAuth.instance.currentUser?.uid;

  // display name
  String? get username => FirebaseAuth.instance.currentUser?.displayName;

  // LOG IN WITH GOOGLE FUNCTION
  Future<AuthResult> signInWithGoogle() async {
    try {
      // interactive sign in process
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // obtain auth details from request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // create a new credential for the user
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // sign in with the firebase method
      await FirebaseAuth.instance.signInWithCredential(credential);
      return AuthResult.success;
    } catch (e) {
      error = e.toString();
      return AuthResult.failure;
    }
  }

  Future<AuthResult> signout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return AuthResult.success;
    } catch (e) {
      error = e.toString();
      return AuthResult.failure;
    }
  }
}
