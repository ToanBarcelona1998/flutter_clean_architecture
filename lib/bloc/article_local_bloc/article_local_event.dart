part of 'article_local_bloc.dart';

abstract class ArticleLocalEvent extends Equatable{
  const ArticleLocalEvent();
  @override
  List<Object?> get props => [];
}
class GetLocalArticleEvent extends ArticleLocalEvent{
  final bool isLoadMore;
  const GetLocalArticleEvent({this.isLoadMore=false});
}

class RemoveLocalArticleEvent extends ArticleLocalEvent{
  final Article article;

  const RemoveLocalArticleEvent({required this.article});
}