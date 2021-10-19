import 'package:flutter_clean_architecture/core/core.dart';
import 'package:flutter_clean_architecture/domain/domain.dart';

class SaveArticleUseCase implements UseCase<void,Article>{
  final ArticlesIRepository _repository;

  SaveArticleUseCase(this._repository);

  @override
  Future<void> call({required Article param}) {
    return _repository.saveArticle(param);
  }

}