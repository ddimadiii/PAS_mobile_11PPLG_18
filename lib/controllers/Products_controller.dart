import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pas_moobile_11pplg_18/models/model_product.dart';

class ProductsController extends GetxController {
  static ProductsController get to => Get.find();
  var products = <ModelProduct>[].obs;
  var loading = false.obs;

  final url = 'https://fakestoreapi.com/products';

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  fetchProducts() async {
    try {
      loading.value = true;
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final List list = json.decode(res.body);
        products.value = list.map((e) => ModelProduct.fromMap(e)).toList();
      } else {
        Get.snackbar('Error', 'Failed fetching products');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      loading.value = false;
    }
  }

  /// helper to force UI refresh if needed
  void refresh() {
    products.refresh();
  }
}
