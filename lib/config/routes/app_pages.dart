import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const init = AppRoutes.login;

  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => Container(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => Container(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => Container(),
      transition: Transition.leftToRight,
    ),
  ];
}
