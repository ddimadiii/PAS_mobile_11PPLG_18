import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_moobile_11pplg_18/controllers/splashscreen_controller.dart';

class SplashScreenPage extends StatelessWidget {
  SplashScreenPage({super.key});

  final controller = Get.find<SplashscreenController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Add background color
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/cart.png',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 24),
              const Text(
                "Loading...",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              const SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
