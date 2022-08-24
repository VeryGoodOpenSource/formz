import 'package:freezed_annotation/freezed_annotation.dart';

part 'amount_errors.freezed.dart';

@freezed
class AmountValidationError with _$AmountValidationError {
  const factory AmountValidationError.outOfRange({
    required String amount,
    required double min,
    required double max,
  }) = OutOfRangeAmountValidationError;

  const factory AmountValidationError.parsing({
    required String amount,
  }) = ParsingAmountValidationError;

  const factory AmountValidationError.required() =
      RequiredAmountValidationError;
}
