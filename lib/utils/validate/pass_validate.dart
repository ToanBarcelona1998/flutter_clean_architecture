import 'package:formz/formz.dart';

enum PassValidateError{
  empty,
}
class PassValidate extends FormzInput<String, PassValidateError>{
  const PassValidate.dirty({String value = ''}) : super.dirty(value);

  const PassValidate.pure() : super.pure('');

  @override
  PassValidateError? validator(String value) {
    return value.isNotEmpty ? null : PassValidateError.empty;
  }

}