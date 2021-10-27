part of 'login_bloc.dart';

class LoginState extends Equatable {
  final UserValidate userValidate;
  final PassValidate passValidate;
  final FormzStatus status;
  final String ?message;

  const LoginState({
    this.userValidate = const UserValidate.pure(),
    this.passValidate = const PassValidate.pure(),
    this.status = FormzStatus.pure,
    this.message
  });

  LoginState copyWith({
    UserValidate? userValidate,
    PassValidate? passValidate,
    FormzStatus? status,
    String ?message,
  }) {
    return LoginState(
      userValidate: userValidate ?? this.userValidate,
      passValidate: passValidate ?? this.passValidate,
      status: status ?? this.status,
      message: message
    );
  }

  @override
  List<Object?> get props => [userValidate, passValidate, status ,message];
}
