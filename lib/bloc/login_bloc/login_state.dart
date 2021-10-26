part of 'login_bloc.dart';

class LoginState extends Equatable {
  final UserValidate? userValidate;
  final PassValidate? passValidate;
  final FormzStatus status;

  const LoginState({this.userValidate, this.passValidate, this.status = FormzStatus.pure});

  LoginState copyWith({
    UserValidate? userValidate,
    PassValidate? passValidate,
    FormzStatus? status,
  }) {
    return LoginState(
      userValidate: userValidate ?? this.userValidate,
      passValidate: passValidate ?? this.passValidate,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [userValidate, passValidate , status];
}
