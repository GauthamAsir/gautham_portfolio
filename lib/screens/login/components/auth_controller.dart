import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_portfolio/global.dart';
import 'package:responsive_portfolio/models/full_data_model.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController(),
      titleController = TextEditingController(),
      descriptionController = TextEditingController(),
      longDescController = TextEditingController();

  User? get firebaseUser => auth.currentUser;

  RxBool obscure = true.obs, loading = false.obs;

  Future fetchUser() async {}

  Future<bool> addProject(List<ProjectModel> list) async {
    loading.value = true;

    List<Map<String, dynamic>> maps = [];

    list.forEach((element) {
      maps.add(element.toMap());
    });

    var data = await firestore
        .collection('Configs')
        .doc('data')
        .update({'projects': maps}).then((value) {
      return true;
    }).catchError((onError) {
      showCustomSnackBar(onError.toString());
      return false;
    });
    return data;
  }

  Future<bool> loginUser() async {
    loading.value = true;
    var data = await auth
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .catchError((onError) {
      log('Error ${onError.toString()}');
      showCustomSnackBar(onError.toString(), snackType: SnackType.Error);
    });

    return data.user != null;
  }
}
