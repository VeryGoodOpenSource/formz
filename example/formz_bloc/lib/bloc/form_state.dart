import 'package:formz/formz.dart';

class FormState extends FormzInput<String, String> {
  FormState.dirty(String value) : super.dirty(value);
  FormState.pure(String value) : super.dirty(value);

  @override
  String validator(String value) {
    return value?.isNotEmpty ? null : 'must fill';
  }
}
