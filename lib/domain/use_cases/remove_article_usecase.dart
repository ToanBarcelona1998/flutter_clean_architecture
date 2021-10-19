import 'package:flutter_clean_architecture/core/core.dart';
import 'package:flutter_clean_architecture/domain/domain.dart';

class RemoveArticleUseCase implements UseCase<void, Article>{
  final ArticlesIRepository _repository;

  RemoveArticleUseCase(this._repository);

  @override
  Future<void> call({required Article param}) {
    return _repository.removeArticle(param);
  }

}