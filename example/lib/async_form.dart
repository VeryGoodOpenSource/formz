import 'dart:async';

import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

/// Usernames that are already in use, used to simulate an asynchronous check.
const _takenUsernames = {'admin', 'dash', 'flutter'};

class AsyncForm extends StatefulWidget {
  const new({super.key});

  @override
  State<AsyncForm> createState() => _AsyncFormState();
}

class _AsyncFormState extends State<AsyncForm> {
  late AsyncFormState _state;
  late final TextEditingController _usernameController;

  void _onUsernameChanged() {
    final value = _usernameController.text;
    if (!_state.username.isPure && value == _state.username.value) return;

    // Only run the asynchronous check when the synchronous validation passes.
    if (_state.username.validator(value) != null) {
      setState(() => _state = AsyncFormState(username: Username.dirty(value)));
      return;
    }

    setState(() {
      _state = AsyncFormState(
        username: Username.dirty(
          value,
          asyncStatus: FormzAsyncValidationStatus.inProgress,
        ),
      );
    });
    unawaited(_validateUsernameAsync(value));
  }

  Future<void> _validateUsernameAsync(String value) async {
    final isTaken = await _isUsernameTaken(value);

    // Ignore the result if the username changed while it was being checked.
    if (!mounted || _state.username.value != value) return;

    setState(() {
      _state = AsyncFormState(
        username: Username.dirty(
          value,
          asyncStatus: FormzAsyncValidationStatus.completed,
          asyncError: isTaken ? UsernameValidationError.taken : null,
        ),
      );
    });
  }

  Future<bool> _isUsernameTaken(String username) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return _takenUsernames.contains(username.toLowerCase());
  }

  void _onSubmit() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('Welcome, ${_state.username.value}! 🎉')),
      );

    _usernameController.clear();
    setState(() => _state = const AsyncFormState());
  }

  @override
  void initState() {
    super.initState();
    _state = const AsyncFormState();
    _usernameController = TextEditingController(text: _state.username.value)
      ..addListener(_onUsernameChanged);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final username = _state.username;

    return Column(
      children: [
        TextField(
          key: const Key('asyncForm_usernameInput'),
          controller: _usernameController,
          decoration: InputDecoration(
            icon: const Icon(Icons.person),
            labelText: 'Username',
            helperText: 'Try "dash" to see a username that is already taken',
            errorText: username.displayError?.text(),
            suffixIcon: username.asyncStatus.isInProgress
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: SizedBox.square(
                      dimension: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : username.isValid
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null,
          ),
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          key: const Key('asyncForm_submit'),
          // The form is only valid once the asynchronous check has completed.
          onPressed: _state.isValid ? _onSubmit : null,
          child: const Text('Create account'),
        ),
      ],
    );
  }
}

class AsyncFormState with FormzMixin {
  const new({this.username = const Username.pure()});

  final Username username;

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [username];
}

enum UsernameValidationError { empty, tooShort, taken }

class Username extends FormzInput<String, UsernameValidationError>
    with FormzInputAsyncValidationMixin {
  const new pure()
    : asyncStatus = FormzAsyncValidationStatus.initial,
      asyncError = null,
      super.pure('');

  const new dirty(
    super.value, {
    this.asyncStatus = FormzAsyncValidationStatus.initial,
    this.asyncError,
  }) : super.dirty();

  @override
  final FormzAsyncValidationStatus asyncStatus;

  @override
  final UsernameValidationError? asyncError;

  @override
  UsernameValidationError? validator(String value) {
    if (value.isEmpty) {
      return UsernameValidationError.empty;
    } else if (value.length < 3) {
      return UsernameValidationError.tooShort;
    }

    return null;
  }
}

extension on UsernameValidationError {
  String text() {
    switch (this) {
      case UsernameValidationError.empty:
        return 'Please enter a username';
      case UsernameValidationError.tooShort:
        return 'Username must be at least 3 characters';
      case UsernameValidationError.taken:
        return 'This username is already taken';
    }
  }
}
