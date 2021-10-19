import 'package:flutter_clean_architecture/core/core.dart';
import 'package:flutter_clean_architecture/domain/domain.dart';

class GetArticleUseCase implements UseCase<DataState<List<Article>>, Map<String,dynamic>>{
  final ArticlesIRepository _repository;

  GetArticleUseCase(this._repository);

  @override
  Future<DataState<List<Article>>> call({required Map<String, dynamic> param}) async{
    return  await _repository.getBreakingNewsArticle(param: param);
  }
}