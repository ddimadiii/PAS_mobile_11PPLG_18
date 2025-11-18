import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pas_moobile_11pplg_18/controllers/Products_controller.dart';
import 'package:pas_moobile_11pplg_18/controllers/auth_controller.dart';
import 'package:pas_moobile_11pplg_18/controllers/bookmark_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<BookmarkController>(() => BookmarkController());
    Get.lazyPut<ProductsController>(() => ProductsController());
  }
}
