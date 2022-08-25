import 'package:example/async/ui/shared/forms/validation_errors/email_errors.dart';
import 'package:formz/formz.dart';

class Email extends AsyncFormzInput<String, EmailValidationError> {
  const Email(
    super.value, {
    super.error,
    super.validationStatus,
    this.isRequired = true,
  });

  final bool isRequired;

  Email copyWith({
    String? value,
    EmailValidationError? error,
    AsyncFormzInputValidationStatus? validationStatus,
    bool? isValidating,
    bool? isRequired,
  }) {
    return Email(
      value ?? this.value,
      error: error ?? this.error,
      validationStatus: validationStatus ?? this.validationStatus,
      isRequired: isRequired ?? this.isRequired,
    );
  }

  Email copyWithResetError({
    String? value,
    AsyncFormzInputValidationStatus? validationStatus,
    bool? isRequired,
  }) {
    return Email(
      value ?? this.value,
      validationStatus: validationStatus ?? this.validationStatus,
      isRequired: isRequired ?? this.isRequired,
    );
  }
}
