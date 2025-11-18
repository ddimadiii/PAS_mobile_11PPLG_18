import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pas_moobile_11pplg_18/models/auth_model.dart';
import 'package:pas_moobile_11pplg_18/models/model_register.dart';
import 'package:pas_moobile_11pplg_18/network/api_config.dart';
import 'package:pas_moobile_11pplg_18/routes/Routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final username = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final email = TextEditingController();

  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  var usernameStored = ''.obs;
  var emailStored = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  @override
  void onClose() {
    username.dispose();
    password.dispose();
    fullName.dispose();
    email.dispose();
    super.onClose();
  }

  Future<void> loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    usernameStored.value = prefs.getString('username') ?? '';
    emailStored.value = prefs.getString('email') ?? '';
  }

  Future<void> login() async {
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
          await prefs.setString('username', username.text);

          await loadUserProfile();

          Get.snackbar(
            "Auth",
            "Login Success",
            backgroundColor: Colors.greenAccent,
          );
          Get.offAllNamed(Routes.initial);
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
          "Failed Login (${res.statusCode})",
          backgroundColor: Colors.redAccent,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Exception",
        e.toString(),
        backgroundColor: Colors.redAccent,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    if (username.text.isEmpty ||
        password.text.isEmpty ||
        fullName.text.isEmpty ||
        email.text.isEmpty) {
      Get.snackbar(
        "Auth",
        "All fields must be filled",
        backgroundColor: Colors.redAccent,
      );
      return;
    }

    try {
      isLoading.value = true;

      final res = await http.post(
        Uri.parse("${ApiConfig.baseURL}/latihan/register-user"),
        body: {
          "username": username.text,
          "password": password.text,
          "full_name": fullName.text,
          "email": email.text,
        },
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        final jsonData = json.decode(res.body);
        final model = RegisterModel.fromJson(jsonData);

        if (model.status == true) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('email', model.email);
          await prefs.setString('username', model.username);

          Get.snackbar(
            "Auth",
            "Register Success",
            backgroundColor: Colors.greenAccent,
          );

          username.clear();
          password.clear();
          fullName.clear();
          email.clear();

          Future.delayed(const Duration(seconds: 1), () {
            Get.offNamed(Routes.login);
          });
        } else {
          Get.snackbar(
            "Auth",
            model.message ?? "Register failed",
            backgroundColor: Colors.redAccent,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed Register (${res.statusCode})",
          backgroundColor: Colors.redAccent,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Exception",
        e.toString(),
        backgroundColor: Colors.redAccent,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    Get.defaultDialog(
      title: "Confirm",
      middleText: "Are you sure you want to logout?",
      textCancel: "No",
      textConfirm: "Yes",
      confirmTextColor: Colors.white,
      onConfirm: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();

        usernameStored.value = '';
        emailStored.value = '';

        Get.delete<AuthController>();

        Get.offAllNamed(Routes.login);
      },
    );
  }
}
