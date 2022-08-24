import 'package:example/async/ui/feature/register/cubit/register_state.dart';
import 'package:example/async/ui/shared/forms/validators/amount_validator.dart';
import 'package:example/async/ui/shared/forms/validators/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({
    required AmountValidator amountValidator,
    required EmailValidator emailValidator,
  })  : _amountValidator = amountValidator,
        _emailValidator = emailValidator,
        super(RegisterState());

  final AmountValidator _amountValidator;
  final EmailValidator _emailValidator;

  Future<void> amountChanged(String value) async {
    emit(
      state.copyWith(
        amount: state.amount.copyWithExceptError(
          value: value,
          isValidating: true,
        ),
      ),
    );
    emit(
      state.copyWith(
        amount: state.amount.copyWith(
          error: await _amountValidator.validate(state.amount),
          isValidating: false,
        ),
      ),
    );
    _updateFormState();
  }

  Future<void> emailChanged(String value) async {
    emit(
      state.copyWith(
        email: state.email.copyWithExceptError(
          value: value,
          isValidating: true,
        ),
      ),
    );
    emit(
      state.copyWith(
        email: state.email.copyWith(
          error: await _emailValidator.validate(state.email),
          isValidating: false,
        ),
      ),
    );
    _updateFormState();
  }

  void _updateFormState() {
    emit(
      state.copyWith(
        isFormValid: Formz.validate([
          state.amount,
          state.email,
        ]),
      ),
    );
  }
}
