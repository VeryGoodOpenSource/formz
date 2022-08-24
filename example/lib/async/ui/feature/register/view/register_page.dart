import 'package:example/async/ui/feature/register/cubit/register_cubit.dart';
import 'package:example/async/ui/feature/register/view/register_view.dart';
import 'package:example/async/ui/shared/forms/validators/amount_validator.dart';
import 'package:example/async/ui/shared/forms/validators/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(
        amountValidator: const AmountValidator(),
        emailValidator: EmailValidator(
          emailRepository: context.read(),
        ),
      ),
      child: const RegisterView(),
    );
  }
}
