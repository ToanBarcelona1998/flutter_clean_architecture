import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/app_config.dart';
import 'package:flutter_clean_architecture/config/config.dart';
import 'package:flutter_clean_architecture/di.dart';
import 'package:get/get.dart';
import 'bloc/bloc.dart';
import 'config/theme/theme.dart' show AppTheme;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ArticleBloc>(
          create: (_) =>
          getIt()
            ..add(
              const GetArticleEvent(isLoadMore: false),
            ),),
        BlocProvider<ArticleLocalBloc>(
          create: (_) =>
          getIt(),),
      ],
      child: GetMaterialApp(
        getPages: AppPages.routes,
        initialRoute: AppPages.init,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
