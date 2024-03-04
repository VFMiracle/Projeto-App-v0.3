import 'package:flutter/material.dart';

class DeletionDialogView extends StatelessWidget{
  final String _title;
  final VoidCallback _deletionFunction;

  const DeletionDialogView(String title, VoidCallback deletionFunction, {Key? key}): _title = title, _deletionFunction = deletionFunction, super(key: key);

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
      title: Text(
        _title,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 24),
      )
    );
  }
}