import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final int ?id;
  final String? title, content, url, urlImage ,description;
  final String? publishAt;

  const Article({this.id, this.title, this.content, this.url, this.publishAt, this.urlImage , this.description});

  @override
  List<Object?> get props => [id, title, content, url, urlImage, publishAt];
}
