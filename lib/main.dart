import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/config/config.dart';
import 'package:flutter_clean_architecture/utils/utils.dart';
import 'package:get/get.dart';
import 'config/theme/theme.dart' show AppTheme;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.instance;
  runApp(
    const AppProvider(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.routes,
      initialRoute: AppPages.init,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      title: Message.appTitle,
    );
  }
}
