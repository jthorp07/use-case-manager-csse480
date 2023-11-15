import 'package:flutter/material.dart';
import 'package:use_case_manager/components/color_scheme.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final void Function() clickCallback;

  const LoginButton({
    super.key,
    required this.text,
    required this.clickCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: 250.0,
      margin: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: UCMColorScheme.roseRed,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextButton(
        onPressed: clickCallback,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
