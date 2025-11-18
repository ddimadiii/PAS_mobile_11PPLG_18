import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_moobile_11pplg_18/controllers/auth_controller.dart';
import 'package:pas_moobile_11pplg_18/widgets/button_widget.dart';
import 'package:pas_moobile_11pplg_18/widgets/textfield_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.find();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    Image.asset('assets/images/cart.png', height: 150),

                    const SizedBox(height: 20),
                    const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 40),

                    AppTextField(
                      label: "Username",
                      prefixIcon: const Icon(Icons.person_outline_rounded),
                      controller: controller.username,
                    ),

                    const SizedBox(height: 16),

                    AppTextField(
                      label: "Full Name",
                      prefixIcon: const Icon(Icons.badge_rounded),
                      controller: controller.fullName,
                    ),

                    const SizedBox(height: 16),

                    AppTextField(
                      label: "Email",
                      prefixIcon: const Icon(Icons.email_rounded),
                      controller: controller.email,
                    ),

                    const SizedBox(height: 16),

                    Obx(() => AppTextField(
                          label: "Password",
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          controller: controller.password,
                          obscureText: !controller.isPasswordVisible.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordVisible.value
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off_rounded,
                            ),
                            onPressed: () {
                              controller.isPasswordVisible.toggle();
                            },
                          ),
                        )),

                    const SizedBox(height: 25),

                    Obx(() => controller.isLoading.value
                        ? const Padding(
                            padding: EdgeInsets.all(12),
                            child: CircularProgressIndicator(),
                          )
                        : AppButton(
                            text: "Register",
                            onPressed: controller.register,
                          )),

                    const SizedBox(height: 16),

                    TextButton(
                      onPressed: () => Get.toNamed("/login"),
                      child: const Text("Sudah punya akun? Login"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
