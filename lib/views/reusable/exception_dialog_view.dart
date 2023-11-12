import 'package:flutter/material.dart';

class ExceptionDialogView extends StatelessWidget{
  final String _message;

  const ExceptionDialogView(String message, {Key? key}) : _message = message, super(key: key);

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      actions: [
        TextButton(
          child: Text(
            "Close",
            style: Theme.of(context).textTheme.displaySmall,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
      content: Text(_message),
      title: Text(
        "ERROR",
        style: TextStyle(
          color: Theme.of(context).colorScheme.error,
        )
      ),
    );
  }
}