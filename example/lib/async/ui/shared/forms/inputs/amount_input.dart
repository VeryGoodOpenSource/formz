import 'package:example/async/ui/shared/forms/validation_errors/amount_errors.dart';
import 'package:formz/formz.dart';

class Amount extends AsyncFormzInput<String, AmountValidationError> {
  const Amount(
    super.value, {
    super.error,
    super.validationStatus,
    this.isRequired = true,
    this.min = 0.0,
    this.max = double.maxFinite,
  });

  final bool isRequired;
  final double min;
  final double max;

  Amount copyWith({
    String? value,
    AmountValidationError? error,
    AsyncFormzInputValidationStatus? validationStatus,
    bool? isValidating,
    bool? isRequired,
    double? min,
    double? max,
  }) {
    return Amount(
      value ?? this.value,
      error: error ?? this.error,
      validationStatus: validationStatus ?? this.validationStatus,
      isRequired: isRequired ?? this.isRequired,
      min: min ?? this.min,
      max: max ?? this.max,
    );
  }

  Amount copyWithResetError({
    String? value,
    AsyncFormzInputValidationStatus? validationStatus,
    bool? isRequired,
    double? min,
    double? max,
  }) {
    return Amount(
      value ?? this.value,
      validationStatus: validationStatus ?? this.validationStatus,
      isRequired: isRequired ?? this.isRequired,
      min: min ?? this.min,
      max: max ?? this.max,
    );
  }
}
