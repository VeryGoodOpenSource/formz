import 'package:example/async/ui/shared/forms/inputs/amount_input.dart';
import 'package:example/async/ui/shared/forms/inputs/email_input.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_state.freezed.dart';

@freezed
class RegisterState with _$RegisterState {
  factory RegisterState({
    @Default(false) bool isFormValid,
    @Default(Amount('', max: 0.5)) Amount amount,
    @Default(Email('')) Email email,
  }) = _RegisterState;
}
