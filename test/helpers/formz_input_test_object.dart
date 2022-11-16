import 'package:formz/formz.dart';

class FormzInputIsValidTestObject extends FormzInputBase<dynamic, dynamic> {
  FormzInputIsValidTestObject({
    required this.isValid,
  });

  @override
  dynamic get error => throw UnimplementedError();

  @override
  final bool isValid;

  @override
  dynamic get value => throw UnimplementedError();
}
