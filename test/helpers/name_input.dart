import 'package:formz/formz.dart';

enum NameInputError { empty }

class NameInput extends FormzInput<String, NameInputError> {
  const NameInput.pure({String value = ''}) : super.pure(value);
  const NameInput.dirty({String value = ''}) : super.dirty(value);

  @override
  NameInputError validator(String value) {
    return value?.isNotEmpty == true ? null : NameInputError.empty;
  }
}
