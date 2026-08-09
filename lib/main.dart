import 'package:ecommerce_app/core/controllers/auth_controllers.dart';
import 'package:ecommerce_app/core/controllers/theme_controller.dart';
import 'package:ecommerce_app/core/utils/app_strings.dart';
import 'package:ecommerce_app/core/utils/app_theme.dart';
import 'package:ecommerce_app/core/view/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(ThemeController());
  Get.put(AuthControllers());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return GetBuilder<ThemeController>(
      builder: (controller) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appTitle,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.themeMode,
          //defaultTransition: Transition.fade,
          home: SplashScreen(),
        );
      },
    );
  }
}
