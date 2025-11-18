import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    // load user profile dari shared prefs
    auth.loadUserProfile();

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // FOTO PROFIL
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/default_pp.png'),
              ),

              const SizedBox(height: 20),

              // USERNAME
              Text(
                auth.usernameStored.value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              // EMAIL
              Text(
                auth.emailStored.value,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 30),

              // LOGOUT BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => auth.logout(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.all(14),
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
