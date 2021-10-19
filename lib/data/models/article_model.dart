import 'package:flutter_clean_architecture/domain/domain.dart';

class ArticleModel extends Article {
  const ArticleModel({
    required int id,
    String? title,
    String? content,
    String? url,
    String? urlImage,
    DateTime? publishAt,
  }) : super(
          id: id,
          url: url,
          title: title,
          content: content,
          urlImage: urlImage,
          publishAt: publishAt,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        publishAt: json['publishedAt'],
        urlImage: json['urlToimage'],
        url: json['url'],
      );
}
