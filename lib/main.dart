import 'package:ecommerce_app/core/controllers/theme_controller.dart';
import 'package:ecommerce_app/core/utils/app_Themes.dart';
import 'package:ecommerce_app/core/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  Get.put(ThemeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return GetBuilder<ThemeController>(
      builder: (controller) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fashion Store',
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: themeController.themeMode,
          //defaultTransition: Transition.fade,
          home: const SplashScreen(),
        );
      },
    );
  }
}
