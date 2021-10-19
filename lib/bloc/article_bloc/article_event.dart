part of 'article_bloc.dart';

abstract class ArticleEvent extends Equatable{
  const ArticleEvent();
  @override
  List<Object?> get props => [];
}
class GetArticleEvent extends ArticleEvent{
  final bool isLoadMore;
  const GetArticleEvent({this.isLoadMore=false});
}