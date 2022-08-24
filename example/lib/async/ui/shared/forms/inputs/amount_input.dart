import 'package:decimal/decimal.dart';
import 'package:example/async/ui/shared/forms/validation_errors/amount_errors.dart';
import 'package:formz/formz.dart';

const _kDefaultRequired = true;
const _kDefaultMin = 0.0;
const _kDefaultMax = double.maxFinite;

class Amount extends AsyncFormzInput<String, AmountValidationError> {
  const Amount(
    String value, {
    bool isPure = true,
    AmountValidationError? error,
    bool isValidating = false,
    this.isRequired = _kDefaultRequired,
    this.min = _kDefaultMin,
    this.max = _kDefaultMax,
  }) : super(
          value,
          isPure: isPure,
          error: error,
          isValidating: isValidating,
        );

  const Amount.pure({
    bool isRequired = _kDefaultRequired,
    double min = _kDefaultMin,
    double max = _kDefaultMax,
  }) : this(
          '',
          isPure: true,
          isRequired: isRequired,
          min: min,
          max: max,
          isValidating: false,
        );

  const Amount.dirty(
    String value, {
    bool isRequired = _kDefaultRequired,
    double min = _kDefaultMin,
    double max = _kDefaultMax,
    AmountValidationError? error,
    bool isValidating = false,
  }) : this(
          value,
          isPure: false,
          isRequired: isRequired,
          min: min,
          max: max,
          error: error,
          isValidating: isValidating,
        );

  final bool isRequired;
  final double min;
  final double max;

  Amount copyWith({
    String? value,
    AmountValidationError? error,
    bool? isValidating,
    bool? isRequired,
    double? min,
    double? max,
  }) {
    final newValue = value ?? this.value;
    return Amount(
      newValue,
      isPure: isPure && newValue.isEmpty,
      error: error ?? this.error,
      isValidating: isValidating ?? this.isValidating,
      isRequired: isRequired ?? this.isRequired,
      min: min ?? this.min,
      max: max ?? this.max,
    );
  }

  Amount copyWithExceptError({
    String? value,
    bool? isValidating,
    bool? isRequired,
    double? min,
    double? max,
  }) {
    final newValue = value ?? this.value;
    return Amount(
      newValue,
      isPure: isPure && newValue.isEmpty,
      isValidating: isValidating ?? this.isValidating,
      isRequired: isRequired ?? this.isRequired,
      min: min ?? this.min,
      max: max ?? this.max,
    );
  }

  double toDouble() => double.parse(value);

  Decimal toDecimal() => Decimal.parse(value);

  double? toDoubleOrNull() => double.tryParse(value);

  Decimal? toDecimalOrNull() => Decimal.tryParse(value);

  Decimal toDecimalOr(Decimal or) => Decimal.tryParse(value) ?? or;

  Decimal toDecimalOrZero() => toDecimalOr(Decimal.zero);

  @override
  String toString() {
    return '''
Amount(
  isPure: $isPure, 
  value: '$value', 
  error: ${error.runtimeType}, 
  isValidating: $isValidating, 
  isRequired: $isRequired, 
  min: $min, 
  max: $max
)''';
  }

  @override
  int get hashCode =>
      value.hashCode ^
      isPure.hashCode ^
      error.hashCode ^
      isValidating.hashCode ^
      isRequired.hashCode ^
      min.hashCode ^
      max.hashCode;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is Amount &&
        other.value == value &&
        other.isPure == isPure &&
        other.error == error &&
        other.isValidating == isValidating &&
        other.isRequired == isRequired &&
        other.min == min &&
        other.max == max;
  }
}