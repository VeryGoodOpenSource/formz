import 'package:formz/formz.dart';

enum NameAsyncInputError { empty }

class NameAsyncInput extends AsyncFormzInput<String, NameAsyncInputError> {
  const NameAsyncInput(
    super.value, {
    super.error,
    super.validationStatus,
  });
}

class NameAsyncFormzInputValidator extends AsyncFormzInputValidator<
    NameAsyncInput, String, NameAsyncInputError> {
  @override
  Future<NameAsyncInputError> validate(NameAsyncInput input) async {
    throw UnimplementedError();
  }
}
