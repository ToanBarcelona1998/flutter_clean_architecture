
part of 'article_local_bloc.dart';


// ignore: must_be_immutable
abstract class ArticleLocalState extends Equatable {
  List<Article>? listArticle;
  bool? isLoadMore;

  ArticleLocalState({this.listArticle, this.isLoadMore = false});

  @override
  List<Object?> get props => [listArticle, isLoadMore,];
}

// ignore: must_be_immutable
class ArticleLocalStateLoading extends ArticleLocalState {
  ArticleLocalStateLoading({required bool isLoadMore, List<Article>? listArticle})
      : super(isLoadMore: isLoadMore, listArticle: listArticle);
}
// ignore: must_be_immutable
class ArticleLocalStateDone extends ArticleLocalState{
  ArticleLocalStateDone({required List<Article> listArticle}) : super(listArticle: listArticle);
}