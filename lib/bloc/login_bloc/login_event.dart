part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable{
  const LoginEvent();
  @override
  List<Object?> get props => [];
}
class OnChangeUserNameEvent extends LoginEvent{
  final String userName;

  const OnChangeUserNameEvent(this.userName);
}
class OnChangePassWordEvent extends LoginEvent{
  final String password;

  const OnChangePassWordEvent(this.password);
}

class OnSubmitLoginEvent extends LoginEvent{
  const OnSubmitLoginEvent();
}