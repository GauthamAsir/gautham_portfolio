import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_portfolio/global.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();

  User? firebaseUser;

  RxBool obscure = true.obs, loading = false.obs;

  Future<bool> loginUser() async {
    loading.value = true;
    var data = await auth
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .catchError((onError) {
      log('Error ${onError.toString()}');
      showCustomSnackBar(onError.toString(), snackType: SnackType.Error);
    });

    if (data.user != null) {
      firebaseUser = data.user;
      return true;
    }

    return false;
  }
}
