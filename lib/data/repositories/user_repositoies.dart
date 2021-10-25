import 'package:flutter_clean_architecture/data/data.dart';
import 'package:flutter_clean_architecture/domain/domain.dart';
class UserRepositories implements UserIRepositories{
  final UserLocalService _localService;

  UserRepositories(this._localService);

  @override
  Future<String?> getToken() async{
    await _localService.getToken();
  }

  @override
  Future<void> setToken({required String token}) async{
    await _localService.setToken(token: token);
  }

}