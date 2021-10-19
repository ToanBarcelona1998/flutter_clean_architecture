import 'package:flutter_clean_architecture/domain/domain.dart';

class ArticleModel extends Article {
  const ArticleModel({
    int ?id,
    String? title,
    String? content,
    String? url,
    String? urlImage,
    String ? description,
    String? publishAt,
  }) : super(
          id: id,
          url: url,
          title: title,
          content: content,
          urlImage: urlImage,
          description: description,
          publishAt: publishAt,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        publishAt: json['publishedAt'],
        description: json['description'],
        urlImage: json['urlToImage'],
        url: json['url'],
      );
}
