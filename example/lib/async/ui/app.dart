import 'package:example/async/data/repositories/email_repository.dart';
import 'package:example/async/ui/feature/register/view/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: const EmailRepository(),
      child: const MaterialApp(
        title: 'Example',
        home: RegisterPage(),
      ),
    );
  }
}
