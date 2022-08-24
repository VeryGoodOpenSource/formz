import 'package:example/async/ui/shared/forms/validation_errors/email_errors.dart';
import 'package:formz/formz.dart';

const _kDefaultRequired = true;

class Email extends AsyncFormzInput<String, EmailValidationError> {
  const Email(
    String value, {
    bool isPure = true,
    EmailValidationError? error,
    bool validating = false,
    this.isRequired = _kDefaultRequired,
  }) : super(
          value,
          isPure: isPure,
          error: error,
          validating: validating,
        );

  const Email.pure({
    bool isRequired = _kDefaultRequired,
  }) : this(
          '',
          isPure: true,
          isRequired: isRequired,
          validating: false,
        );

  const Email.dirty(
    String value, {
    bool isRequired = _kDefaultRequired,
    EmailValidationError? error,
    bool validating = false,
  }) : this(
          value,
          isPure: false,
          isRequired: isRequired,
          error: error,
          validating: validating,
        );

  final bool isRequired;

  Email copyWith({
    String? value,
    EmailValidationError? error,
    bool? validating,
    bool? isRequired,
  }) {
    final newValue = value ?? this.value;
    return Email(
      newValue,
      isPure: isPure && newValue.isEmpty,
      error: error ?? this.error,
      validating: validating ?? this.validating,
      isRequired: isRequired ?? this.isRequired,
    );
  }

  Email copyWithExceptError({
    String? value,
    bool? validating,
    bool? isRequired,
  }) {
    final newValue = value ?? this.value;
    return Email(
      newValue,
      isPure: isPure && newValue.isEmpty,
      validating: validating ?? this.validating,
      isRequired: isRequired ?? this.isRequired,
    );
  }

  @override
  String toString() {
    return '''
Email(
  isPure: $isPure, 
  value: '$value', 
  error: ${error.runtimeType}, 
  validating: $validating, 
  isRequired: $isRequired
)''';
  }

  @override
  int get hashCode =>
      value.hashCode ^
      isPure.hashCode ^
      error.hashCode ^
      validating.hashCode ^
      isRequired.hashCode;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Email &&
        other.value == value &&
        other.isPure == isPure &&
        other.error == error &&
        other.validating == validating &&
        other.isRequired == isRequired;
  }
}
