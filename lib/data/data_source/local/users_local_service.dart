import 'package:flutter_clean_architecture/utils/utils.dart';
import 'package:hive/hive.dart';

class UserLocalService{
  late Box<String> _box;

  Future<String?> getToken()async{
    String ?token;

    _box = await Hive.openBox(Types.userBox);

    token = _box.get(Types.tokenKey);

    await _box.close();

    return token;
  }

  Future<void> setToken({required String token})async{
    _box = await Hive.openBox(Types.userBox);

    return _box.put(Types.tokenKey, token);
  }
}