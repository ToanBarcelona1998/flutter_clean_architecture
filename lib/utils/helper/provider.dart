import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/bloc/bloc.dart';
import 'package:flutter_clean_architecture/di.dart';

class AppProvider extends StatelessWidget {
  final Widget child;

  const AppProvider({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ArticleBloc>(
          create: (_) => getIt()
            ..add(
              const GetArticleEvent(isLoadMore: false),
            ),
        ),
        BlocProvider<ArticleLocalBloc>(
          create: (_) => getIt(),
        ),
      ],
      child: child,
    );
  }
}
