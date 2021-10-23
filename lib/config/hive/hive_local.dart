import 'dart:io';
import 'package:flutter_clean_architecture/domain/domain.dart' show ArticleAdapter;
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveLocal{
  static HiveLocal ?_hiveLocal;

  static Future get instance async =>await _getInstance();

  static Future _getInstance()async{
    _hiveLocal??= HiveLocal._();
    await _hiveLocal!._init();
    return _hiveLocal!;
  }
  HiveLocal._();

  Future<void> _init()async{
    Directory directory=await getApplicationDocumentsDirectory();
    Hive..init(directory.path)..registerAdapter(ArticleAdapter());
  }


}