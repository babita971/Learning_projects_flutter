import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  late User profileData;

  void onInit() async {
    profileData = FirebaseAuth.instance.currentUser!;
    super.onInit();
  }
}

