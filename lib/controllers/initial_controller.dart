import 'package:get/get.dart';
import 'package:pas_moobile_11pplg_18/controllers/Products_controller.dart';

class InitialController extends GetxController {
  var currentIndex = 0.obs;
  void changeTab(int index) => currentIndex.value = index;

  @override
  void onInit() {
    super.onInit();
    // Ensure ProductsController is available and fetch products on app init
    if (Get.isRegistered<ProductsController>()) {
      Get.find<ProductsController>().fetchProducts();
    } else {
      final pc = Get.put(ProductsController());
      pc.fetchProducts();
    }
  }
}
