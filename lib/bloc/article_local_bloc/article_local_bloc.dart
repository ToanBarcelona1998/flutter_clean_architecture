import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/bloc/bloc.dart';
import 'package:flutter_clean_architecture/domain/domain.dart';

part 'article_local_event.dart';
part 'artilce_local_state.dart';

class ArticleLocalBloc extends Base<ArticleLocalEvent, ArticleLocalState> {
  ArticleLocalBloc(this._getArticleLocalUseCase, this._removeArticleUseCase)
      : super(ArticleLocalStateLoading(isLoadMore: false)) {
    on<GetLocalArticleEvent>(_onGetLocalArticle);
    on<RemoveLocalArticleEvent>(_onRemoveLocalArticle);
  }
  final Map<String,Article> _mapArticle = <String,Article>{};

  int _page = 1;
  static const _pageSize = 10;

  final GetArticleLocalUseCase _getArticleLocalUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;

  Future<void> _onGetLocalArticle(GetLocalArticleEvent event, Emitter emit)async{

    final _oldState= state;

    emit(ArticleLocalStateLoading(isLoadMore: event.isLoadMore , listArticle: _oldState.listArticle));
    if(event.isLoadMore){
      _page++;
    }
    final result = await _getArticleLocalUseCase.call(param: [_page, _pageSize]);
    for(Article article in result){
      _mapArticle[article.title!] = article;
    }
    emit(ArticleLocalStateDone(listArticle: _mapArticle.isEmpty? [] : _mapArticle.values.toList()));
  }

  Future<void> _onRemoveLocalArticle(RemoveLocalArticleEvent event , Emitter emit)async{
    await _removeArticleUseCase.call(param: event.article);

    _mapArticle.removeWhere((key, value) => value == event.article);

    emit(ArticleLocalStateDone(listArticle: _mapArticle.values.toList()));

  }

  static ArticleLocalBloc of(context) => BlocProvider.of<ArticleLocalBloc>(context);


  @override
  void refreshState() {
    _page=1;
    state.listArticle!.clear();
    state.isLoadMore=false;
    _mapArticle.clear();
  }
}

