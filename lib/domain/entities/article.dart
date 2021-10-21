import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'article.g.dart';

@HiveType(typeId: 0)
class Article extends Equatable {
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final String? content;
  @HiveField(2)
  final String? url;
  @HiveField(3)
  final String? urlImage;
  @HiveField(4)
  final String? description;
  @HiveField(5)
  final String? publishAt;

  const Article({this.title, this.content, this.url, this.publishAt, this.urlImage, this.description});

  @override
  List<Object?> get props => [title, content, url, urlImage, publishAt];
}
