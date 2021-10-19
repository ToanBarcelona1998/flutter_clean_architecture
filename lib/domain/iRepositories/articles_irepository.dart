import 'package:flutter_clean_architecture/core/core.dart';
import 'package:flutter_clean_architecture/domain/domain.dart';

abstract class ArticlesIRepository{
  Future<DataState<List<Article>>> getBreakingNewsArticle({required Map<String,dynamic> param});

  Future<List<Article>> getLocalArticle();

  Future<void> saveArticle(Article article);

  Future<void> removeArticle(Article article);
}