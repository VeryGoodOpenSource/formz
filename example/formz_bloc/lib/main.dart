import 'package:flutter/material.dart';

import 'bloc/text_field_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      home: TxtExamples(),
    );
  }
}

class TxtExamples extends StatefulWidget {
  @override
  _TxtExamplesState createState() => _TxtExamplesState();
}

class _TxtExamplesState extends State<TxtExamples> {
  TextFieldCubit textFieldCubit;

  String txtError;

  @override
  void initState() {
    textFieldCubit = TextFieldCubit();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    textFieldCubit.listen((value) {
      if (!value.valid) {
        setState(() {
          txtError = value.error;
        });
      } else {
        setState(() {
          txtError = null;
        });
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    textFieldCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'text input',
                  errorText: txtError,
                ),
                onChanged: (value) {
                  textFieldCubit.setTxt(value);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
