import 'package:flutter_clean_architecture/core/core.dart';
import 'package:flutter_clean_architecture/domain/domain.dart';

class GetTokenUseCase implements UseCase<String?, String>{
  final UserIRepositories _userIRepositories;

  GetTokenUseCase(this._userIRepositories);

  @override
  Future<String?> call({required String param}) async{
    return await _userIRepositories.getToken();
  }

}