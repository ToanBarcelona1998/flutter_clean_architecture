import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/bloc/article_bloc/article_bloc.dart';
import 'package:flutter_clean_architecture/core/core.dart';
import 'package:flutter_clean_architecture/data/data.dart';
import 'package:flutter_clean_architecture/data/repositories/article_repositories.dart';
import 'package:flutter_clean_architecture/domain/domain.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

// register dependency here
Future<void> init() async {
  //get token here
  getIt.registerSingleton<Dio>(Dio(BaseOptions(
      baseUrl: dotenv.env[Types.domainArticle].toString(), connectTimeout: connectTimeout, receiveTimeout: receivedTimeout)));
  getIt.registerSingleton<NewsApiService>(NewsApiService(getIt()));
  getIt.registerSingleton<ArticlesIRepository>(ArticleRepository(getIt()));

  getIt.registerSingleton<GetArticleUseCase>(GetArticleUseCase(getIt()));

  getIt.registerFactory(() => ArticleBloc(getIt()));
}
