import 'package:get_it/get_it.dart';

class AppInjector{
  static AppInjector ?injector;

  static late GetIt getIt;

  factory AppInjector(){
    injector??=AppInjector.init();
    return injector!;
  }

  AppInjector.init(){
    getIt = GetIt.instance;
  }


  void initInjector()async{
    
  }
}