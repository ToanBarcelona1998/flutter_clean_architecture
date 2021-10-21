import 'package:flutter_clean_architecture/config/routes/app_pages.dart';
import 'package:get/get.dart';

class Navigate{
  Navigate._();
  static goBack() async => Get.back();
  static goLogin() async => Get.toNamed(AppRoutes.login);
  static goHome() async => Get.toNamed(AppRoutes.home);
  static goRegister() async => Get.toNamed(AppRoutes.register);
  static goLocal() async => Get.toNamed(AppRoutes.local);
}