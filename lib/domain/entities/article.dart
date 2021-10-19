import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final int id;
  final String? title, content, url, urlImage;
  final DateTime? publishAt;

  const Article({required this.id, this.title, this.content, this.url, this.publishAt, this.urlImage});

  @override
  List<Object?> get props => [id, title, content, url, urlImage, publishAt];
}
