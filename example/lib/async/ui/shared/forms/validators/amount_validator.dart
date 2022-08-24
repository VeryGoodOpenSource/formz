import 'package:example/async/ui/shared/forms/inputs/amount_input.dart';
import 'package:example/async/ui/shared/forms/validation_errors/amount_errors.dart';
import 'package:formz/formz.dart';

class AmountValidator
    extends AsyncFormzInputValidator<Amount, String, AmountValidationError> {
  const AmountValidator();

  @override
  Future<AmountValidationError?> validate(Amount input) async {
    if (input.isRequired && input.value.isEmpty) {
      return const AmountValidationError.required();
    }
    final parsed = double.tryParse(input.value);
    if (parsed == null || parsed.isNaN) {
      return AmountValidationError.parsing(
        amount: input.value,
      );
    } else if (parsed < input.min || parsed > input.max) {
      return AmountValidationError.outOfRange(
        amount: input.value,
        min: input.min,
        max: input.max,
      );
    }
    return null;
  }
}
