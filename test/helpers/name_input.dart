import 'package:formz/formz.dart';

enum NameInputError { empty }

class NameInput extends FormzInput<String, NameInputError> {
  const NameInput.pure({String value = ''}) : super.pure(value);
  const NameInput.dirty({String value = ''}) : super.dirty(value);

  @override
  NameInputError? validator(String value) {
    return value.isEmpty ? NameInputError.empty : null;
  }

  @override
  String? validatorMessage(NameInputError? error) {
    if (error == NameInputError.empty) {
      return 'Obligatory field';
    }
    return null;
  }
}

class NameInputFormzMixin with FormzMixin {
  NameInputFormzMixin({this.name = const NameInput.pure()});

  final NameInput name;

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [name];
}
