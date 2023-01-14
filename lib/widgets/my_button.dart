import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonText;
  VoidCallback onPressed;

  MyButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      child: Text(buttonText),
    );
  }
}
