import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_moobile_11pplg_18/routes/AppPages.dart';
import 'package:pas_moobile_11pplg_18/routes/Routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Color mainCol = Colors.red;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.of(context).copyWith(primary: mainCol),
      ),
      initialRoute: Routes.splash,
      getPages: AppPages.pages,
    );
  }
}
