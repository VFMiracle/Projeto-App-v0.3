import 'package:flutter/material.dart';

class DeletionDialogView extends StatelessWidget{
  final String _title;
  final VoidCallback _deletionFunction;
  final Widget? _content;

  const DeletionDialogView(String title, VoidCallback deletionFunction, {Widget? content, Key? key}): _title = title, _deletionFunction = deletionFunction,
    _content = content, super(key: key);

  @override
  AlertDialog build(BuildContext context){
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: (){
            _deletionFunction();
            Navigator.of(context).pop();
          },
          child: const Text("Yes")
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("No")
        ),
      ],
      content: _content,
      title: Text(
        _title,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 24),
      )
    );
  }
}