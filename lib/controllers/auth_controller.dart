import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../models/user.dart ' as model;

import '../constant/helpers.dart';
import '../view/screens/screen_dashboard.dart';

class AuthController extends GetxController {

  RxBool loading = false.obs;
  Rx<TextEditingController> emailController = TextEditingController(text:"careno@gmail.com").obs;
  Rx<TextEditingController> passwordController = TextEditingController(text:"654321").obs;

  Future<String> SignUp() async {
    String response = "";
    loading.value = true;
    String email = emailController.value.text.trim();
    String password = passwordController.value.text.trim();
    int id = DateTime.now().millisecondsSinceEpoch;
    if (email.isNotEmpty || password.isNotEmpty) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password).then((value) async {
        var uid = value.user!.uid;
    await  setDatabase(email, password, uid,id);
        response = "success";
      }).catchError((error) {
        response = error.toString();
        loading.value = false;
      });
    }
    else {
      response = "Email and Password required";
      loading.value = false;
    }
    return response.toString();
  }
  Future<String> LoginIn() async {
    String response = "";
    loading.value = true;
    String email = emailController.value.text.trim();
    String password = passwordController.value.text.trim();
    int id = DateTime.now().millisecondsSinceEpoch;
    if (email.isNotEmpty || password.isNotEmpty) {
      await FirebaseAuth.instance..signInWithEmailAndPassword(
          email: email, password: password).then((value) async {
        var uid = value.user!.uid;
        response = "success";
        print(response.toString());
        Get.offAll(ScreenDashboard());


      }).catchError((error) {
        response = error.toString();
        loading.value = false;
        print(response.toString());

      });
    }
    else {
      response = "Email and Password required";
      loading.value = false;
      print(response.toString());

    }
    return response.toString();
  }

  Future<void> setDatabase(String email, password,uid,  int id) async {
    var setData = model.User(
        uid: uid,
        userType: "admin",
        phoneNumber: "",
        imageUrl: "",
        address: "",
        name: "",
        email: email,
        profileDescription: "",
        gender: "",
        notificationToken: "",
        status: "",
        dob: 0,
        timeStamp: id,
        lat: 10.10,
        lng: 10.10,
        currentBalance: 0.0,
        notification: false,
        isVerified: false,
        isBlocked: false
    );
    await usersRef.doc(uid).set(setData.toMap());
  }
  void forgotPassword() {
    var email = emailController.value.text.trim();
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      print("Reset email sent");
    }).catchError((error) {
      print(error);
    });
  }
}