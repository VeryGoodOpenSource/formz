import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

void main() {
  runApp(App());
}

/// App
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Form Validation')),
        body: MyForm(),
      ),
    );
  }
}

/// Contains the contents of login, password inputs, and submit button
class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  var password = const Password.dirty();
  var email = const Email.pure();
  var status = FormzStatus.pure;

  void setEmail(String value) {
    setState(() {
      email = Email.dirty(value);
    });
  }

  void setPassword(String value) {
    setState(() {
      password = Password.dirty(value);
    });
  }

  void setStatus(FormzStatus value) {
    setState(() {
      status = value;
    });
  }

  @override
  void initState() {
    super.initState();
    password = const Password.pure();
    email = const Email.pure();
    status = FormzStatus.pure;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            initialValue: email.value,
            decoration: InputDecoration(
              icon: const Icon(Icons.email),
              labelText: 'Email',
              helperText: 'A complete, valid email e.g. joe@gmail.com',
              errorText: email.invalid
                  ? 'Please ensure the email entered is valid'
                  : null,
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: setEmail,
            textInputAction: TextInputAction.next,
          ),
          TextFormField(
            initialValue: password.value,
            decoration: InputDecoration(
              icon: const Icon(Icons.lock),
              helperText:
                  '''Password should be at least 8 characters with at least one letter and number''',
              helperMaxLines: 2,
              labelText: 'Password',
              errorMaxLines: 2,
              errorText: password.invalid
                  ? '''Password must be at least 8 characters and contain at least one letter and number'''
                  : null,
            ),
            obscureText: true,
            onChanged: setPassword,
            textInputAction: TextInputAction.done,
          ),
          ElevatedButton(
            onPressed: () => {
              status = Formz.validate([email, password]),
              print(status),
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

/// enum for email input state
// ignore: public_member_api_docs
enum EmailValidationError { invalid }

/// FormzInput for email TextForm
class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure([String value = '']) : super.pure(value);
  // ignore: public_member_api_docs
  const Email.dirty([String value = '']) : super.dirty(value);

  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError? validator(String? value) {
    return _emailRegex.hasMatch(value ?? '')
        ? null
        : EmailValidationError.invalid;
  }
}

/// enum for password input state
// ignore: public_member_api_docs
enum PasswordValidationError { invalid }

/// FormzInput for password TextForm
class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure([String value = '']) : super.pure(value);
  // ignore: public_member_api_docs
  const Password.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegex =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  PasswordValidationError? validator(String? value) {
    return _passwordRegex.hasMatch(value ?? '')
        ? null
        : PasswordValidationError.invalid;
  }
}
