import 'package:flutter_clean_architecture/domain/domain.dart';
import 'package:flutter_clean_architecture/utils/utils.dart';
import 'package:hive/hive.dart';

class NewsLocalService{
  late Box<Article> _box;

  Future<void> saveArticle(Article articleModel)async{
    _box = await Hive.openBox(Types.articleBox);

    if(_box.containsKey(articleModel.title?.substring(0,4).replaceAll('‘', '').replaceAll('’', '') ?? '${articleModel.urlImage?.substring(0,4)}')){
      return;
    }
    await _box.put(articleModel.title?.substring(0,10).replaceAll('‘', '').replaceAll('’', '') ?? '${articleModel.urlImage?.substring(0,4)}',articleModel);

    await _box.close();

    return;
  }

  Future<List<Article>> getListArticle({required int page,required int pageCount})async{
    List<Article> listArticle = List.empty(growable: true);
    _box =await Hive.openBox(Types.articleBox);

    if(_box.values.length <= page * pageCount){
      listArticle.addAll(_box.values.toList());
    }else{
      listArticle.addAll(_box.values.toList().getRange(0, page * pageCount));
    }

    await _box.close();

    return listArticle;
  }

  Future<void> removeArticle(Article articleModel)async{
    _box = await Hive.openBox(Types.articleBox);

    await _box.delete(articleModel.title?.substring(0,4).replaceAll('‘', '').replaceAll('’', '') ?? '${articleModel.urlImage?.substring(0,4)}');

    await _box.close();
  }

  Future<void> updateArticle(Article articleModel)async{
    _box = await Hive.openBox(Types.articleBox);

    await _box.delete(articleModel.title?.replaceAll('‘', '').replaceAll('’', ''));

    await _box.put(articleModel.title?.replaceAll('‘', '').replaceAll('’', ''), articleModel);

    await _box.close();
  }

}