import 'package:flutter/material.dart';

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
      theme: ThemeData(
        platform: TargetPlatform.iOS
      ),
    );
  }
}
