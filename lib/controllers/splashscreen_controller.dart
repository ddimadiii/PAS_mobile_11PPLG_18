import 'package:get/get.dart';
import 'package:pas_moobile_11pplg_18/routes/Routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashscreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  void checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      Get.offAllNamed(Routes.login);
    } else {
      Get.offAllNamed(Routes.initial);
    }
  }
}
