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
          child: Text("Yes", style: Theme.of(context).textTheme.displaySmall)
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("No", style: Theme.of(context).textTheme.displaySmall)
        ),
      ],
      title: Text(_title)
    );
  }
}