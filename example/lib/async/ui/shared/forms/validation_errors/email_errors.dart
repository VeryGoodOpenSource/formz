import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_errors.freezed.dart';

@freezed
class EmailValidationError with _$EmailValidationError {
  const factory EmailValidationError.invalidFormat() =
      InvalidFormatEmailValidationError;

  const factory EmailValidationError.alreadyExists() =
      AlreadyExistsEmailValidationError;

  const factory EmailValidationError.required() = RequiredEmailValidationError;
}
