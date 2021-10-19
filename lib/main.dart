import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/app_config.dart';
import 'config/theme/theme.dart' show AppTheme;

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.instance;
 runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key ?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme
    );
  }
}
