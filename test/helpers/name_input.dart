import 'package:formz/formz.dart';

enum NameInputError { empty }

class NameInput extends FormzInput<String, NameInputError> {
  NameInput.pure({String value = ''}) : super.pure(value);
  NameInput.dirty({String value = ''}) : super.dirty(value);

  @override
  NameInputError? validator(String value) {
    return value.isEmpty ? NameInputError.empty : null;
  }
}

class NameInputFormzMixin with FormzMixin {
  NameInputFormzMixin({NameInput? name}) : name = name ?? NameInput.pure();

  final NameInput name;

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [name];
}
