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
        amount: state.amount.copyWithResetError(
          value: value,
          validationStatus: AsyncFormzInputValidationStatus.validating,
        ),
      ),
    );
    final error = await _amountValidator.validate(state.amount);
    emit(
      state.copyWith(
        amount: state.amount.copyWith(
          error: error,
          validationStatus: AsyncFormzInputValidationStatus.validated,
        ),
      ),
    );
    _updateFormState();
  }

  Future<void> emailChanged(String value) async {
    emit(
      state.copyWith(
        email: state.email.copyWithResetError(value: value),
      ),
    );
    final canValidate = _emailValidator.canValidate(state.email);
    if (!canValidate) {
      return;
    }
    emit(
      state.copyWith(
        email: state.email.copyWith(
          validationStatus: AsyncFormzInputValidationStatus.validating,
        ),
      ),
    );
    final error = await _emailValidator.validate(state.email);
    emit(
      state.copyWith(
        email: state.email.copyWith(
          error: error,
          validationStatus: AsyncFormzInputValidationStatus.validated,
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
