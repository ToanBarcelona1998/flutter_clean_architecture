import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/core.dart';
import 'package:flutter_clean_architecture/domain/domain.dart';
import 'package:flutter_clean_architecture/handle_error.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent,ArticleState> with HandleError{
  ArticleBloc(this._useCase , this._saveArticleUseCase) : super(ArticleStateLoading(isLoadMore: false)){
    on<GetArticleEvent>(_onGetArticle);
  }
  final GetArticleUseCase _useCase;
  final SaveArticleUseCase _saveArticleUseCase;

  final Map<String,Article> _mapArticle = <String,Article>{};
  int _page = 1;
  static const int _pageSize=10;

  Future<void> _onGetArticle(GetArticleEvent event, Emitter emit)async{

    final _oldState = state;

    emit(ArticleStateLoading(isLoadMore: event.isLoadMore ,listArticle: _oldState.listArticle));
    if(event.isLoadMore){
      _page++;
    }
    Map<String,dynamic> param = <String,dynamic>{};
    param[Types.apiKey] = dotenv.env[Types.apiKeyArticle];
    param[Types.country] =  country;
    param[Types.category] = category;
    param[Types.page] = _page;
    param[Types.pageSize] = _pageSize;
    final result = await _useCase.call(param: param);

    if(result is DataSuccess){
      if(result.data!=null){
        for(Article article in result.data!){
          await _saveArticleUseCase.call(param: article);
          _mapArticle[article.title!] = article;
        }
      }
      emit(ArticleStateDone(listArticle: _mapArticle.values.toList()));
    }

    if(result is DataError){
      emit(ArticleStateError(error: handleError(result.error!) ,listArticle: _oldState.listArticle ,isLoadMore: event.isLoadMore));

      if(_oldState.listArticle!=null && _oldState.listArticle!.isNotEmpty){
        await Future.delayed(const Duration(seconds: 1));

        emit(ArticleStateDone(listArticle: _oldState.listArticle ?? []));
      }
    }
  }

  static ArticleBloc of(context) => BlocProvider.of<ArticleBloc>(context);

  void dispose(){
    _page=1;
    _mapArticle.clear();
    state.listArticle = null;
    state.isLoadMore=false;
    state.error=null;
  }

}