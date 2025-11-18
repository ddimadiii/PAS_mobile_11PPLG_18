import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_moobile_11pplg_18/controllers/initial_controller.dart';
import 'package:pas_moobile_11pplg_18/pages/Favorites_page.dart';
import 'package:pas_moobile_11pplg_18/pages/product_page.dart';
import 'package:pas_moobile_11pplg_18/pages/profile_page.dart';

class InitialPage extends StatelessWidget {
  InitialPage({super.key});

  final InitialController nav = Get.put(InitialController());

  final pages = [ProductsPage(), FavoritesPage(), ProfilePage()];

  final titles = ["Products", "Favorites", "Profile"];

  @override
  Widget build(BuildContext context) {
    final Color mainCol = Colors.red;
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text(
            titles[nav.currentIndex.value], // judul berubah sesuai tab
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: mainCol,
          centerTitle: true,
        ),
        
        body: pages[nav.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: nav.currentIndex.value,
          onTap: nav.changeTab,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 25),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark, size: 25),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 25),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
