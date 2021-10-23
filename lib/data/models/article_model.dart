import 'package:flutter_clean_architecture/domain/domain.dart' show Article;
import 'package:flutter_clean_architecture/utils/utils.dart' show Types;

class ArticleModel extends Article {
  const ArticleModel({
    String? title,
    String? content,
    String? url,
    String? urlImage,
    String? description,
    String? publishAt,
  }) : super(
          url: url,
          title: title,
          content: content,
          urlImage: urlImage,
          description: description,
          publishAt: publishAt,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        title: json[Types.title],
        content: json[Types.content],
        publishAt: json[Types.publishAt],
        description: json[Types.description],
        urlImage: json[Types.urlToImage],
        url: json[Types.url],
      );
}
