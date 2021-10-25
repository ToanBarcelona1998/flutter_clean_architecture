import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/bloc/bloc.dart';
import 'package:flutter_clean_architecture/domain/domain.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Base<SplashEvent, SplashState>{
  SplashBloc(this._getTokenUseCase) : super(SplashState()){
    on<SplashEvent>(_getScreenEvent);
  }

  final GetTokenUseCase _getTokenUseCase;

  void _getScreenEvent(SplashEvent event, Emitter emit)async{
    // ignore: void_checks
    String ?token = await _getTokenUseCase.call(param: ());
    if(token == null){
      emit(SplashState(hasToken: false));
    }else{
      emit(SplashState(hasToken: true));
    }
  }

  @override
  void refreshState() {

  }

}