import 'package:flutter_clean_architecture/core/core.dart';
import 'package:flutter_clean_architecture/domain/domain.dart';

class SetTokenUseCase implements UseCase<void , String>{
  final UserIRepositories _userIRepositories;

  SetTokenUseCase(this._userIRepositories);

  @override
  Future<void> call({required String param}) async{
    return await _userIRepositories.setToken(token: param);
  }

}