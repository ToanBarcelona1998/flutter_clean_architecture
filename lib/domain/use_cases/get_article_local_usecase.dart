import 'package:flutter_clean_architecture/core/core.dart';
import 'package:flutter_clean_architecture/domain/domain.dart';

class GetArticleLocalUseCase implements UseCase<List<Article>, void>{
  final ArticlesIRepository _repository;

  GetArticleLocalUseCase(this._repository);

  @override
  Future<List<Article>> call({required void param}) {
    return _repository.getLocalArticle();
  }

}