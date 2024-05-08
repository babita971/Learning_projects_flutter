import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthController extends GetxController {
  // For signup
  Future<dynamic> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
    // required PhoneAuthCredential phone,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Please provide a strong password.';
      } else if (e.code == 'email-already-in-use') {
        return 'An account already exists with entered email address.';
      } else if (e.code == 'email-already-in-use') {
        return 'Email already used. Go to login page.';
      } else if (e.code == 'network-request-failed') {
        return 'Network request failed. Please try again.';
      }
    } catch (e) {
      print(e);
    }

    return user;
  }

  // For login
  Future<dynamic> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found with provided email address.';
      } else if (e.code == 'wrong-password') {
        return 'Incorrect password provided.';
      }
    } catch (e) {
      print(e);
    }

    return user;
  }

  Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }

  signOutUser() async {
    await FirebaseAuth.instance.signOut();
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    await FacebookAuth.instance.logOut();
  }

  Future<dynamic?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        return user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          return 'Account exists with different account';
        } else if (e.code == 'invalid-credential') {
          return 'Invalid credentials';
        }
      } catch (e) {
        return 'Some error occurred. Please try again.';
      }
    }
  }

  Future<dynamic> signInWithFacebook() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    final LoginResult loginResult = await FacebookAuth.instance.login(permissions: [
      'email', 'public_profile'
    ]);
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    try {
      final UserCredential userCredential =
          await auth.signInWithCredential(facebookAuthCredential);

      user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        return 'Account exists with different account';
      } else if (e.code == 'invalid-credential') {
        return 'Invalid credentials';
      }
    } catch (e) {
      return 'Some error occurred. Please try again.';
    }
  }
}
