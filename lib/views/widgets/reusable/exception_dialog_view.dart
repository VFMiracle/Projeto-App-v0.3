import 'package:flutter/material.dart';

class ExceptionDialogView extends StatelessWidget{
  final String _message;

  const ExceptionDialogView(String message, {Key? key}) : _message = message, super(key: key);

  @override
  AlertDialog build(BuildContext context){
    return AlertDialog(
      actions: [
        TextButton(
          child: const Text("Close"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
      content: Text(_message),
      title: const Text("ERROR",),
    );
  }
}