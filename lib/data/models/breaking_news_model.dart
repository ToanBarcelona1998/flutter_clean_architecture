import 'package:flutter_clean_architecture/utils/utils.dart' show Types;
import 'article_model.dart';
class BreakingNewsResponseModel {
  final String status;
  final int totalResults;
  final List<ArticleModel> articles;

  BreakingNewsResponseModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory BreakingNewsResponseModel.fromJson(Map<String, dynamic> json) {
    return BreakingNewsResponseModel(
      status: json[Types.status] as String,
      totalResults: json[Types.totalResult] as int,
      articles: List<ArticleModel>.from(
        (json[Types.listArticle] as List<dynamic>).map(
              (e) => ArticleModel.fromJson(e as Map<String, dynamic>),
        ),
      ),
    );
  }
}