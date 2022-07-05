import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameSignupController = TextEditingController();
  TextEditingController passwordSignupController = TextEditingController();
  TextEditingController emailSignupController = TextEditingController();
  TextEditingController phoneSignupController = TextEditingController();
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> logIn(String email, String password) async {
    try {
      _isLoading.value = true;
      User? user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      _isLoading.value = false;
      return user;
    } catch (e) {
      return null;
    }
  }

  Future logOut() async {
    await _auth.signOut();
  }

  Future<User?> signup({
    required String userName,
    required String email,
    required String password,
    required String phone,
  }) async {
    _isLoading.value = true;
    User? user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      await _db.collection('user').doc(_auth.currentUser!.uid).set({
        "email": email,
        "name": userName,
        "phone": phone,
        "status": "Unavailable",
        "uid": _auth.currentUser!.uid,
      });
    }
    _isLoading.value = false;
    return user;
  }
}
