import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/core/core.dart';
import 'package:flutter_clean_architecture/data/data.dart';
import 'package:flutter_clean_architecture/domain/domain.dart';
class ArticleRepository implements ArticlesIRepository {
  final NewsApiService _apiService;

  ArticleRepository(this._apiService);

  @override
  Future<DataState<List<Article>>> getBreakingNewsArticle({required Map<String, dynamic> param}) async {
    try {
      final httpResponse = await _apiService.getBreakingNewsArticles(param['apiKey'], param['country'], param['category'], param['page'], param['pageSize']);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(data: httpResponse.data.articles);
      } else {
        return DataError(
          dioError: DioError(
              requestOptions: httpResponse.response.requestOptions,
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              type: DioErrorType.response),
        );
      }
    } on DioError catch (err) {
      return DataError(dioError: err);
    }
  }

  @override
  Future<List<Article>> getLocalArticle() async{
    // TODO: implement getLocalArticle
    throw UnimplementedError();
  }

  @override
  Future<void> removeArticle(Article article) async{
    // TODO: implement removeArticle
    throw UnimplementedError();
  }

  @override
  Future<void> saveArticle(Article article) async{
    // TODO: implement saveArticle
    throw UnimplementedError();
  }
}
