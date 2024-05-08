import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/widgets/user_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final _firebaseAuth = FirebaseAuth.instance;

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isSignIn = true;
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  bool isLoadingInProgress = false;
  File? _selectedProfileImage;

  Future<User?> signInWithGoogle() async {
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
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }

    return user;
  }

  void submitSignInInfo() async {
    if (!formkey.currentState!.validate()) {
      return;
    }
    if (!isSignIn && _selectedProfileImage == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please upload profile picture"),
        ),
      );
      return;
    }

    formkey.currentState!.save();
    setState(() {
      isLoadingInProgress = true;
    });
    try {
      if (isSignIn) {
        //SIGN IN
        final userCredentials = await _firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        setState(() {
          isLoadingInProgress = false;
        });
        print(userCredentials);
      } else {
        //SIGN UP
        final userCredentials =
            await _firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        print(userCredentials);
        final storageRef = FirebaseStorage.instance
            .ref()
            .child("user_profile")
            .child("${userCredentials.user!.uid}.jpg");

        await storageRef.putFile(_selectedProfileImage!);
        final downloadURL = await storageRef.getDownloadURL();
        print(downloadURL);

        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
          "user_name": nameController.text,
          // "uid": userCredentials.user!.uid,
          // "email": emailController.text,
          // "password": passwordController.text,
          "image_url": downloadURL,
        });

        setState(() {
          isLoadingInProgress = false;
        });
      }
    } on FirebaseAuthException catch (error) {
      setState(() {
        isLoadingInProgress = false;
      });
      if (error.code == "email-already-in-use") {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ??
                "Authentication Failed as email is already in use!"),
          ),
        );
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? "Authentication Failed!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // double keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Center(
        child: Form(
          key: formkey,
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            // elevation: 10,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 20, top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  !isSignIn
                      ? UserImagePicker(
                          onPickImage: (pickedImage) {
                            _selectedProfileImage = pickedImage;
                          },
                        )
                      : Container(),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: const InputDecoration(
                      label: Text(
                        "Enter email address",
                      ),
                    ),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Email address cannot be empty";
                      }
                      if (!value.contains('@')) {
                        return "Please enter valid email address.";
                      }
                      return null;
                    },
                  ),
                  !isSignIn
                      ? const SizedBox(
                          height: 20,
                        )
                      : const SizedBox(),
                  !isSignIn
                      ? TextFormField(
                          keyboardType: TextInputType.text,
                          controller: nameController,
                          decoration: const InputDecoration(
                            label: Text(
                              "Enter name",
                            ),
                          ),
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Your name cannot be empty";
                            }
                            if (value.trim().length < 4) {
                              return "Please enter valid name.";
                            }
                            return null;
                          },
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      label: Text("Enter password"),
                    ),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Password cannot be empty";
                      }
                      if (value.trim().length < 8) {
                        return "Password should have atleast 8 characters";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        foregroundColor: Colors.white),
                    onPressed: submitSignInInfo,
                    child: isLoadingInProgress
                        ? const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            isSignIn ? "Sign In" : "Sign Up",
                          ),
                  ),
                  isSignIn
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 40, right: 40),
                          child: ElevatedButton(
                            onPressed: () {
                              final user = signInWithGoogle();
                              print(user);
                            },
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  'assets/google_icon.jpg',
                                  width: 20.0,
                                  height: 20.0,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text(
                                  'Continue with Google',
                                ),
                              ],
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isSignIn = !isSignIn;
                        emailController.text = "";
                        passwordController.text = "";
                      });
                    },
                    child: Text(
                      isSignIn
                          ? "I don't have an account."
                          : "I already have an account.",
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
