import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pas_moobile_11pplg_18/models/auth_model.dart';
import 'package:pas_moobile_11pplg_18/network/api_config.dart';
import 'package:pas_moobile_11pplg_18/routes/Routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final username = TextEditingController();
  final password = TextEditingController();

  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  void login() async {
    if (username.text.isEmpty || password.text.isEmpty) {
      Get.snackbar(
        "Auth",
        "Username or password cannot be empty",
        backgroundColor: Colors.redAccent,
      );
      return;
    }

    try {
      isLoading.value = true;

      final res = await http.post(
        Uri.parse("${ApiConfig.baseURL}/latihan/login"),
        body: {"username": username.text, "password": password.text},
      );

      if (res.statusCode == 200) {
        final model = loginModelFromJson(res.body);

        if (model.status) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', model.token);

          Get.snackbar(
            "Auth",
            "Login Success",
            backgroundColor: Colors.greenAccent,
          );

          Get.offNamed(Routes.initial);
        } else {
          Get.snackbar(
            "Auth",
            model.message,
            backgroundColor: Colors.redAccent,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed Login, status: (${res.statusCode})",
          backgroundColor: Colors.redAccent,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Exception",
        e.toString(),
        backgroundColor: Colors.redAccent,
      );
    }
    isLoading.value = false;
  }

  // New register method using API endpoint:
  void register() async {
    if (username.text.isEmpty || password.text.isEmpty) {
      Get.snackbar(
        "Auth",
        "Username or password cannot be empty",
        backgroundColor: Colors.redAccent,
      );
      return;
    }

    try {
      isLoading.value = true;

      final res = await http.post(
        Uri.parse("${ApiConfig.baseURL}/latihan/register-user"),
        body: {"username": username.text, "password": password.text},
      );

      if (res.statusCode == 200) {
        final model = loginModelFromJson(res.body);

        if (model.status) {
          Get.snackbar(
            "Auth",
            "Register Success",
            backgroundColor: Colors.greenAccent,
          );

          Get.offNamed(Routes.login);
        } else {
          Get.snackbar(
            "Auth",
            model.message,
            backgroundColor: Colors.redAccent,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed Register, status: (${res.statusCode})",
          backgroundColor: Colors.redAccent,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Exception",
        e.toString(),
        backgroundColor: Colors.redAccent,
      );
    }

    isLoading.value = false;
  }

  void logout() async {
    Get.defaultDialog(
      title: "Confirm",
      middleText: "Are you sure want to logout?",
      textCancel: "No",
      textConfirm: "Yes",
      confirmTextColor: Colors.white,
      onConfirm: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
        Get.offAllNamed(Routes.login);
      },
    );
  }
}
