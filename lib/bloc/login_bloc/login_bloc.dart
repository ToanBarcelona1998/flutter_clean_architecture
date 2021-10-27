import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/bloc/bloc.dart';
import 'package:flutter_clean_architecture/domain/domain.dart';
import 'package:flutter_clean_architecture/utils/utils.dart';
import 'package:flutter_clean_architecture/utils/validate/pass_validate.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Base<LoginEvent, LoginState> {
  LoginBloc(this._setTokenUseCase) : super(const LoginState()) {
    on<OnChangeUserNameEvent>(_onChangeUserNameEvent);
    on<OnChangePassWordEvent>(_onChangePassWordEvent);
    on<OnSubmitLoginEvent>(_onSubmitLoginEvent);
  }

  SetTokenUseCase _setTokenUseCase;

  void _onChangeUserNameEvent(OnChangeUserNameEvent event, Emitter emit) {
    final userName = UserValidate.dirty(value: event.userName);

    emit(
      state.copyWith(
        userValidate: userName.valid ? userName : const UserValidate.pure(),
        status: Formz.validate([
          userName,
          state.passValidate,
        ]),
      ),
    );
  }

  void _onChangePassWordEvent(OnChangePassWordEvent event, Emitter emit) {
    final passWord = PassValidate.dirty(value: event.password);

    emit(
      state.copyWith(
        passValidate: passWord.valid ? passWord : const PassValidate.pure(),
        status: Formz.validate(
          [passWord, state.userValidate],
        ),
      ),
    );
  }

  Future<void> _onSubmitLoginEvent(OnSubmitLoginEvent event, Emitter emit) async {
    final _userName = state.userValidate.value;
    final _passWord = state.passValidate.value;

    if(_userName.compareTo('toanbarcelona1998@gmail.com') == 0 && _passWord.compareTo('123456')==0){
      await _setTokenUseCase.call(param: token);
      emit(state.copyWith(message: success));
    }else{
      emit(state.copyWith(message: fail));
    }
  }

  static LoginBloc of(context) => BlocProvider.of<LoginBloc>(context);

  @override
  void refreshState() {}
}
