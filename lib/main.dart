import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/config/config.dart';
import 'di.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  AppInjector();
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
