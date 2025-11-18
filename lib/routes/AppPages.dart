import 'package:get/get.dart';
import 'package:pas_moobile_11pplg_18/bindings/app_binding.dart';
import 'package:pas_moobile_11pplg_18/bindings/splashscreen_binding.dart';
import 'package:pas_moobile_11pplg_18/pages/Favorites_page.dart';
import 'package:pas_moobile_11pplg_18/pages/initial_page.dart';
import 'package:pas_moobile_11pplg_18/pages/login_page.dart';
import 'package:pas_moobile_11pplg_18/pages/product_detail_page.dart';
import 'package:pas_moobile_11pplg_18/pages/product_page.dart';
import 'package:pas_moobile_11pplg_18/pages/register_page.dart';
import 'package:pas_moobile_11pplg_18/pages/splash_screen.dart';
import 'package:pas_moobile_11pplg_18/routes/Routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => SplashScreenPage(),
      binding: SplashscreenBinding(),
    ),
    GetPage(name: Routes.login, page: () => LoginPage(), binding: AppBinding()),
    GetPage(
      name: Routes.initial,
      page: () => InitialPage(),
      binding: AppBinding(),
    ),
    GetPage(
      name: Routes.productDetail,
      page: () => ProductDetailPage(product: Get.arguments),
    ),
    GetPage(
      name: Routes.product,
      page: () => ProductsPage(),
      binding: AppBinding(),
    ),
    GetPage(
      name: Routes.favorites,
      page: () => FavoritesPage(),
      binding: AppBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => RegisterPage(),
      binding: AppBinding(),
    ),
  ];
}
