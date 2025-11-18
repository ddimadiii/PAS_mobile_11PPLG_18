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
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 23, 44, 63),
                ),
                child: Text(
                  "Menu",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.calculate),
                title: const Text("Kalkulator"),
                onTap: () {
                  nav.changeTab(0);
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.sports_soccer),
                title: const Text("Football"),
                onTap: () {
                  nav.changeTab(1);
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Profile"),
                onTap: () {
                  nav.changeTab(2);
                  Get.back();
                },
              ),
            ],
          ),
        ),
        body: pages[nav.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: nav.currentIndex.value,
          onTap: nav.changeTab,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate, size: 25),
              label: 'Kalkulator',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_soccer, size: 25),
              label: 'Football',
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
