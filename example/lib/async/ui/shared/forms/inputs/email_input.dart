import 'package:example/async/ui/shared/forms/validation_errors/email_errors.dart';
import 'package:formz/formz.dart';

const _kDefaultRequired = true;

class Email extends AsyncFormzInput<String, EmailValidationError> {
  const Email(
    String value, {
    bool isPure = true,
    EmailValidationError? error,
    bool isValidating = false,
    this.isRequired = _kDefaultRequired,
  }) : super(
          value,
          isPure: isPure,
          error: error,
          isValidating: isValidating,
        );

  const Email.pure({
    bool isRequired = _kDefaultRequired,
  }) : this(
          '',
          isPure: true,
          isRequired: isRequired,
          isValidating: false,
        );

  const Email.dirty(
    String value, {
    bool isRequired = _kDefaultRequired,
    EmailValidationError? error,
    bool isValidating = false,
  }) : this(
          value,
          isPure: false,
          isRequired: isRequired,
          error: error,
          isValidating: isValidating,
        );

  final bool isRequired;

  Email copyWith({
    String? value,
    EmailValidationError? error,
    bool? isValidating,
    bool? isRequired,
  }) {
    final newValue = value ?? this.value;
    return Email(
      newValue,
      isPure: isPure && newValue.isEmpty,
      error: error ?? this.error,
      isValidating: isValidating ?? this.isValidating,
      isRequired: isRequired ?? this.isRequired,
    );
  }

  Email copyWithExceptError({
    String? value,
    bool? isValidating,
    bool? isRequired,
  }) {
    final newValue = value ?? this.value;
    return Email(
      newValue,
      isPure: isPure && newValue.isEmpty,
      isValidating: isValidating ?? this.isValidating,
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
  isValidating: $isValidating, 
  isRequired: $isRequired
)''';
  }

  @override
  int get hashCode =>
      value.hashCode ^
      isPure.hashCode ^
      error.hashCode ^
      isValidating.hashCode ^
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
        other.isValidating == isValidating &&
        other.isRequired == isRequired;
  }
}
