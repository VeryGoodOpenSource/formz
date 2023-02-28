import 'package:formz/formz.dart';

enum RegexInputError { error }

// ignore: must_be_immutable
class RegexInput extends FormzInput<String, RegexInputError> {
  RegexInput.pure({String value = ''}) : super.pure(value);

  RegexInput.dirty({String value = ''}) : super.dirty(value);

  @override
  RegexInputError? validator(String value) {
    _validationCalls++;

    final regExp = RegExp(r'.* (.*)\[(.*)\]:.*');

    if (!regExp.hasMatch(value)) {
      return RegexInputError.error;
    }

    return null;
  }

  int get validationCalls => _validationCalls;

  int _validationCalls = 0;
}
