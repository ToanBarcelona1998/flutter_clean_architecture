import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/ui/ui.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const init = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => Container(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => Container(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: AppRoutes.local,
      page: () => const LocalPage(),
      transition: Transition.leftToRight,
    ),
  ];
}
