// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: sort_child_properties_last,prefer_const_constructors

import 'package:ecommerce_app/app_pages.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/modules/login/controller/login_controller.dart';
import 'package:ecommerce_app/modules/signup/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignUpScreen extends GetView<SignUpController> {
  final SignUpController signUpController = Get.find();
  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Form(
              key: signUpController.signUpFormKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontFamily: 'Actonia PERSONAL',
                                color: kContrastColor,
                                fontSize: 35),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Text(
                        'Sign up here to explore our amazing kicks.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Source Sans Pro',
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: TextFormField(
                        controller: signUpController.nameEditingController,
                        validator: (value) {
                          if (GetUtils.isNull(signUpController
                                  .nameEditingController.text) ||
                              signUpController
                                  .nameEditingController.text.isEmpty) {
                            return 'Invalid name.';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.edit_note_rounded,
                            size: 24,
                            color: kSecondaryColor,
                          ),
                          // labelText: 'Enter Email address',
                          hintText: 'Full Name',
                          hintStyle: kTextFormStyle,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 10, vertical: 10),
                    //   child: TextFormField(
                    //     controller: signUpController.phoneEditingController,
                    //     validator: (value) {
                    //       if (!GetUtils.isPhoneNumber(
                    //           signUpController.phoneEditingController.text)) {
                    //         return 'Invalid phone number.';
                    //       }
                    //     },
                    //     decoration: const InputDecoration(
                    //       prefixIcon: Icon(
                    //         Icons.call,
                    //         size: 24,
                    //         color: kSecondaryColor,
                    //       ),
                    //       hintText: 'Phone Number',
                    //       hintStyle: kTextFormStyle,
                    //       border: InputBorder.none,
                    //     ),
                    //   ),
                    // ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: TextFormField(
                        controller: signUpController.emailEditingController,
                        validator: (value) {
                          if (!GetUtils.isEmail(
                              signUpController.emailEditingController.text)) {
                            return 'Invalid email address.';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: ImageIcon(
                            AssetImage('images/Message 35.png'),
                            size: 24,
                            color: kSecondaryColor,
                          ),
                          // labelText: 'Enter Email address',
                          hintText: 'Email Address',
                          hintStyle: kTextFormStyle,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: TextFormField(
                        obscureText: true,
                        controller: signUpController.passwordEditingController,
                        validator: (value) {
                          // if (!GetUtils.isUsername(signUpController
                          //     .passwordEditingController.text)) {
                          //   return 'Invalid password.';
                          // }
                          if (signUpController
                                  .passwordEditingController.text.length <
                              8) {
                            return 'Password should be atleast 8 characters long.';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: ImageIcon(
                            AssetImage('images/Vector.png'),
                            size: 24,
                            color: kSecondaryColor,
                          ),
                          // labelText: 'Enter Password',
                          hintText: 'Password',
                          hintStyle: kTextFormStyle,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: RawMaterialButton(
                        fillColor: Colors.blue,
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SvgPicture.asset(
                                'images/facebook_svg.svg',
                                width: 20.0,
                                height: 20.0,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Continue with Facebook',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'DM Sans'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        onPressed: () {
                          // Get.snackbar(
                          //   "Facebook Login",
                          //   "Implementation Pending!",
                          //   icon: ImageIcon(
                          //     AssetImage('images/facebook.png'),
                          //     color: Colors.white,
                          //     size: 24,
                          //   ),
                          //   snackPosition: SnackPosition.BOTTOM,
                          //   backgroundColor: Colors.blue,
                          //   borderRadius: 20,
                          //   margin: EdgeInsets.all(15),
                          //   colorText: Colors.white,
                          //   duration: Duration(seconds: 3),
                          //   isDismissible: true,
                          //   dismissDirection: DismissDirection.horizontal,
                          //   forwardAnimationCurve: Curves.easeOutBack,
                          // );
                          loginController.facebookSignInFromFirebase();
                        },
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                      ),
                    ),
                    Container(
                      height: 45,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: RawMaterialButton(
                        fillColor: Colors.white,
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SvgPicture.asset(
                                'images/Google_svg.svg',
                                width: 20.0,
                                height: 20.0,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Continue with Google',
                                  style: TextStyle(
                                      color: Colors.red, fontFamily: 'DM Sans'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        onPressed: () {
                          // Get.snackbar(
                          //   "Google Login",
                          //   "Implementation Pending!",
                          //   icon: ImageIcon(
                          //     AssetImage('images/Google.png'),
                          //     color: Colors.white,
                          //     size: 24,
                          //   ),
                          //   snackPosition: SnackPosition.BOTTOM,
                          //   backgroundColor: Colors.redAccent,
                          //   borderRadius: 20,
                          //   margin: EdgeInsets.all(15),
                          //   colorText: Colors.white,
                          //   duration: Duration(seconds: 3),
                          //   isDismissible: true,
                          //   dismissDirection: DismissDirection.horizontal,
                          //   forwardAnimationCurve: Curves.easeOutBack,
                          // );
                          loginController.googleSignInFromFirebase();
                        },
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                      ),
                    ),
                  ]),
            ),
          ),
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              RawMaterialButton(
                onPressed: () {
                  Get.offAllNamed(Paths.LOGIN);
                },
                child: Container(
                  // message: 'Sign Up with Email Address/Phone number',
                  height: Get.height / 6,
                  alignment: Alignment(0.0, -0.6),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                  ),
                  child: Text("Login", style: TextStyle(color: Colors.white)),
                ),
              ),
              Tooltip(
                message: 'Go to Kicker Store.',
                child: RawMaterialButton(
                  onPressed: () {
                    signUpController.validateSignUp();
                  },
                  child: Container(
                    height: Get.height / 10,
                    width: Get.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Let\'s get Kicking! '),
                        Icon(Icons.arrow_forward, size: 16)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
