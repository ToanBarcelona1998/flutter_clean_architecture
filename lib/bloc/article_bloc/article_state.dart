part of 'article_bloc.dart';
// ignore: must_be_immutable
abstract class ArticleState extends Equatable {
  List<Article>? listArticle;
  bool? isLoadMore;
  String? error;

  ArticleState({this.listArticle, this.isLoadMore = false, this.error});

  @override
  List<Object?> get props => [listArticle, isLoadMore, error];
}
// ignore: must_be_immutable
class ArticleStateLoading extends ArticleState {
   ArticleStateLoading({required bool isLoadMore, List<Article>? listArticle})
      : super(isLoadMore: isLoadMore, listArticle: listArticle);
}
// ignore: must_be_immutable
class ArticleStateDone extends ArticleState {
  ArticleStateDone({required List<Article> listArticle}) : super(listArticle: listArticle);
}
// ignore: must_be_immutable
class ArticleStateError extends ArticleState {
  ArticleStateError({required String error, List<Article>? listArticle, bool isLoadMore = false})
      : super(error: error, listArticle: listArticle, isLoadMore: isLoadMore);
}
