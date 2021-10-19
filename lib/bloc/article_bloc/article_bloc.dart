import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/core.dart';
import 'package:flutter_clean_architecture/domain/domain.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent,ArticleState>{
  ArticleBloc(this._useCase) : super(const ArticleStateLoading(isLoadMore: false)){
    on<GetArticleEvent>(_onGetArticle);
  }
  final GetArticleUseCase _useCase;

  final Map<String,Article> _mapArticle = <String,Article>{};
  int _page = 1;
  static const int _pageSize=20;

  Future<void> _onGetArticle(GetArticleEvent event, Emitter emit)async{
    emit(ArticleStateLoading(isLoadMore: event.isLoadMore));
    if(event.isLoadMore){
      _page++;
    }
    Map<String,dynamic> param = <String,dynamic>{};
    param[ApiParam.apiKey] = '';
    param[ApiParam.country] =  country;
    param[ApiParam.category] = category;
    param[ApiParam.page] = _page;
    param[ApiParam.pageSize] = _pageSize;
    final result = await _useCase.call(param: param);

    if(result is DataSuccess){

      if(result.data!=null){
        for(Article article in result.data!){
          _mapArticle[article.id.toString()] = article;
        }
      }

      emit(ArticleStateDone(listArticle: _mapArticle.values.toList()));
    }

    if(result is DataError){
      emit(ArticleStateError(error: result.error!));
    }
  }

}