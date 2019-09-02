import 'package:firebase_auth/firebase_auth.dart';

class AuthApi {
  static Future<FirebaseUser> registerUser(email, password) async {
    FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user;
  }

  static Future<FirebaseUser> loginUser(email, password) async {
    FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user;
  }

  static Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user;
  }

  static Future<void> signoutUser() async {
    await FirebaseAuth.instance.signOut();
  }
}
