import 'package:flutter/material.dart';
import 'package:todoapp/util/my_button.dart';

// ignore: must_be_immutable
class DailogBox extends StatelessWidget {
  final TextEditingController controller; // Specify the type for better clarity
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DailogBox({
    super.key, 
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the theme colors
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkTheme ? Colors.grey[800] : Colors.grey[300];
    final textColor = isDarkTheme ? Colors.white : Colors.black;
    final hintColor = isDarkTheme ? Colors.grey : Colors.black54;
    final borderColor = isDarkTheme ? Colors.white : Colors.black;

    return AlertDialog(
      backgroundColor: backgroundColor,
      content: SizedBox(
        height: 120,
        // Text field
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              controller: controller,
              style: TextStyle(
                color: textColor,
              ),
              decoration: InputDecoration(
                hintText: 'Enter task here',
                hintStyle: TextStyle(
                  color: hintColor,
                  fontFamily: 'Poppins',
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: borderColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: borderColor,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Save button
                MyButton(text: 'Save', onPressed: onSave,),
                const SizedBox(width: 4),
                // Cancel button
                MyButton(text: 'Cancel', onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
