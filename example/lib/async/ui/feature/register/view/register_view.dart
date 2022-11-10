import 'package:example/async/ui/feature/register/cubit/register_cubit.dart';
import 'package:example/async/ui/shared/components/form_label.dart';
import 'package:example/async/ui/shared/forms/inputs/amount_input.dart';
import 'package:example/async/ui/shared/forms/inputs/email_input.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _FormStatusText(),
            SizedBox(height: 16),
            _AmountTextField(),
            SizedBox(height: 16),
            _EmailTextField(),
          ],
        ),
      ),
    );
  }
}

class _FormStatusText extends StatelessWidget {
  const _FormStatusText();

  @override
  Widget build(BuildContext context) {
    final isFormValid = context.select<RegisterCubit, bool>(
      (c) => c.state.isFormValid,
    );
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: 'Form status: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: isFormValid ? 'valid' : 'invalid',
            style: TextStyle(
              color: isFormValid ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class _AmountTextField extends StatefulWidget {
  const _AmountTextField();

  @override
  State<_AmountTextField> createState() => _AmountTextFieldState();
}

class _AmountTextFieldState extends State<_AmountTextField> {
  late FocusNode textFocusNode;
  late TextEditingController textController;

  @override
  void initState() {
    textController = TextEditingController();
    textFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    final amount = context.select<RegisterCubit, Amount>(
      (c) => c.state.amount,
    );
    if (!textFocusNode.hasFocus) {
      textController.text = amount.value;
    }
    return FormLabel(
      label: _AmountLabel(
        input: amount,
      ),
      child: TextFormField(
        controller: textController,
        focusNode: textFocusNode,
        onChanged: cubit.amountChanged,
        decoration: InputDecoration(
          hintText: r'Amount in $',
          errorText: amount.error?.map(
            outOfRange: (value) =>
                'Amount must be between ${value.min} and ${value.max}',
            parsing: (_) => 'Amount must be a number',
            required: (_) => 'Amount is required',
          ),
        ),
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
        ),
      ),
    );
  }
}

class _EmailTextField extends StatefulWidget {
  const _EmailTextField();

  @override
  State<_EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<_EmailTextField> {
  late FocusNode textFocusNode;
  late TextEditingController textController;

  @override
  void initState() {
    textController = TextEditingController();
    textFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    final email = context.select<RegisterCubit, Email>(
      (c) => c.state.email,
    );
    if (!textFocusNode.hasFocus) {
      textController.text = email.value;
    }
    return FormLabel(
      label: _EmailLabel(
        input: email,
      ),
      child: TextFormField(
        controller: textController,
        focusNode: textFocusNode,
        onChanged: cubit.emailChanged,
        decoration: InputDecoration(
          hintText: 'Enter your email',
          helperText:
              email.validationStatus.isValidating ? 'Validating...' : null,
          errorText: email.validationStatus.isNotValidating
              ? email.error?.map(
                  invalidFormat: (_) => 'Invalid email format',
                  alreadyExists: (_) => 'Email already exists',
                  required: (_) => 'Email is required',
                )
              : null,
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}

class _EmailLabel extends StatelessWidget {
  const _EmailLabel({
    required this.input,
  });

  final Email input;

  @override
  Widget build(BuildContext context) {
    final valStatus = _getValidationStatusText(input.validationStatus);
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: 'Email',
          ),
          TextSpan(
            text:
                ' (is_valid: ${input.isValid}, validation_status: $valStatus)',
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );
  }

  String _getValidationStatusText(AsyncFormzInputValidationStatus status) {
    return status.isPure
        ? 'pure'
        : status.isValidating
            ? 'validating'
            : 'validated';
  }
}

class _AmountLabel extends StatelessWidget {
  const _AmountLabel({
    required this.input,
  });

  final Amount input;

  @override
  Widget build(BuildContext context) {
    final valStatus = _getValidationStatusText(input.validationStatus);
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: 'Amount',
          ),
          TextSpan(
            text:
                ' (is_valid: ${input.isValid}, validation_status: $valStatus)',
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );
  }

  String _getValidationStatusText(AsyncFormzInputValidationStatus status) {
    return status.isPure
        ? 'pure'
        : status.isValidating
            ? 'validating'
            : 'validated';
  }
}
