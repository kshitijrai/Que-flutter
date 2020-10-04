import 'package:Que/components/form_error.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void signUp(String email, String password) async {
  await Firebase.initializeApp();
  FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    final User user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (!user.emailVerified) {
      await user.sendEmailVerification();
    }
    print("Success");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e.toString());
    FormError(
      errors: e.message,
    );
  }
}
