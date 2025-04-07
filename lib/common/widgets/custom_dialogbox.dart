import 'package:flutter/material.dart';

class CustomDialogBox extends StatelessWidget {
  final String message;
  final VoidCallback onTap;

  const CustomDialogBox({
    Key? key,
    required this.message,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmation'),
      content: Text(message),
      actions: [
        // Cancel Button
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        // OK Button
        TextButton(
          onPressed: onTap,
          child: const Text('OK'),
        ),
      ],
    );
  }
}
