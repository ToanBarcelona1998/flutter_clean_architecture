part of 'article_bloc.dart';
abstract class ArticleState extends Equatable{
  final List<Article> ?listArticle;
  final bool ?isLoadMore;
  final DioError ?error;

  const ArticleState({this.listArticle, this.isLoadMore = false, this.error});

  @override
  List<Object?> get props => [listArticle , isLoadMore , error];


}
class ArticleStateLoading extends ArticleState{
  const ArticleStateLoading({required bool isLoadMore}) : super (isLoadMore: isLoadMore);
}

class ArticleStateDone extends ArticleState{
  const ArticleStateDone({required List<Article> listArticle}) : super (listArticle: listArticle);
}
class ArticleStateError extends ArticleState{
  const ArticleStateError({required DioError error}) : super(error: error);
}