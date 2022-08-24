import 'package:flutter/material.dart';

class FormLabel extends StatelessWidget {
  const FormLabel({
    super.key,
    required this.label,
    required this.child,
  });

  final Widget label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTextStyle.merge(
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          child: label,
        ),
        child,
      ],
    );
  }
}
