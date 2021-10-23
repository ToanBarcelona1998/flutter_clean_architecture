import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/core/core.dart';
import 'package:flutter_clean_architecture/data/data.dart';
import 'package:flutter_clean_architecture/domain/domain.dart';
import 'package:flutter_clean_architecture/utils/utils.dart';
class ArticleRepository implements ArticlesIRepository {
  final NewsApiService _apiService;

  final NewsLocalService _localService;

  ArticleRepository(this._apiService ,this._localService);

  @override
  Future<DataState<List<Article>>> getBreakingNewsArticle({required Map<String, dynamic> param}) async {
    try {
      final httpResponse = await _apiService.getBreakingNewsArticles(param[Types.apiKey], param[Types.country], param[Types.category], param[Types.page], param[Types.pageSize]);

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
  Future<List<Article>> getLocalArticle({required List<int> param}) async{
    return await _localService.getListArticle(page: param[0] ,pageCount: param[1]);
  }

  @override
  Future<void> removeArticle(Article article) async{
    await _localService.removeArticle(article);
  }

  @override
  Future<void> saveArticle(Article article) async{
    await _localService.saveArticle(article);
  }
}
