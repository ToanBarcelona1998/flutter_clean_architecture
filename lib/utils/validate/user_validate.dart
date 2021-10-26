import 'package:formz/formz.dart';

enum UserValidateError {
  empty,
}

class UserValidate extends FormzInput<String, UserValidateError> {
  const UserValidate.pure() : super.pure('');

  const UserValidate.dirty({String value = ''}) : super.dirty(value);

  static final RegExp _userRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  @override
  UserValidateError? validator(String? value) {
    return _userRegex.hasMatch(value ?? '') ? null : UserValidateError.empty;
  }
}
