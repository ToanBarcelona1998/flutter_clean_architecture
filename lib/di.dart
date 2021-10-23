import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/data/data.dart';
import 'package:flutter_clean_architecture/domain/domain.dart';
import 'package:flutter_clean_architecture/utils/utils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'bloc/bloc.dart';
import 'data/repositories/article_repositories.dart';

GetIt getIt = GetIt.instance;

// register dependency here
Future<void> init() async {
  getIt.registerSingleton<Dio>(Dio(BaseOptions(
      baseUrl: dotenv.env[Types.domainArticle].toString(), connectTimeout: connectTimeout, receiveTimeout: receivedTimeout,),),);
  getIt.registerSingleton<NewsApiService>(NewsApiService(getIt()));

  getIt.registerSingleton<NewsLocalService>(NewsLocalService());

  getIt.registerSingleton<ArticlesIRepository>(ArticleRepository(getIt() , getIt()));

  getIt.registerSingleton<GetArticleUseCase>(GetArticleUseCase(getIt()));

  getIt.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(getIt()));

  getIt.registerSingleton<GetArticleLocalUseCase>(GetArticleLocalUseCase(getIt()));

  getIt.registerSingleton<RemoveArticleUseCase>(RemoveArticleUseCase(getIt()));

  getIt.registerFactory<ArticleBloc>(() => ArticleBloc(getIt() ,getIt()));

  getIt.registerFactory<ArticleLocalBloc>(() => ArticleLocalBloc(getIt() ,getIt()));
}
