import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;

  MyButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final buttoncolor = isDarkTheme ? Colors.grey[700] : Colors.grey[500];
    

    return MaterialButton(
      onPressed: onPressed,
      color: buttoncolor, 
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: Colors
              .white, // Ensure the text is visible against the button color
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
