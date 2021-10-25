import 'package:flutter_clean_architecture/core/core.dart';
import 'package:flutter_clean_architecture/domain/domain.dart';

class GetArticleLocalUseCase implements UseCase<List<Article>, List<int>>{
  final ArticlesIRepository _repository;

  GetArticleLocalUseCase(this._repository);

  @override
  Future<List<Article>> call({required List<int> param}) {
    return _repository.getLocalArticle(param: param);
  }
}