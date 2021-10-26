import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/bloc/bloc.dart';
import 'package:flutter_clean_architecture/utils/utils.dart';
import 'package:flutter_clean_architecture/utils/validate/pass_validate.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Base<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<OnChangeUserNameEvent>(_onChangeUserNameEvent);
    on<OnChangePassWordEvent>(_onChangePassWordEvent);
    on<OnSubmitLoginEvent>(_onSubmitLoginEvent);
  }

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

  }

  static LoginBloc of(context) => BlocProvider.of<LoginBloc>(context);

  @override
  void refreshState() {}
}
