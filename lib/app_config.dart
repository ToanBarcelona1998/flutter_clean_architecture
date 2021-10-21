import 'package:flutter_clean_architecture/core/core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'di.dart' as di;
import 'hive_local.dart';

class AppConfig{
  static AppConfig ? _config;

  AppConfig._();

  static Future<void> get instance async => _getInstance();

  static Future _getInstance() async {
    _config??= AppConfig._();
    await _config!._init();

    return _config;
  }

  Future<void> _init()async{
    await dotenv.load(fileName: BaseUrl.assetEnv);
    await di.init();
    await HiveLocal.instance;
  }
}