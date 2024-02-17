import 'package:flutter/material.dart';
import 'package:projeto_time_counter/themes/main_dialog_theme.dart';

class DeletionDialogView extends StatelessWidget{
  final String _title;
  final VoidCallback _deletionFunction;

  const DeletionDialogView(String title, VoidCallback deletionFunction, {Key? key}): _title = title, _deletionFunction = deletionFunction, super(key: key);

  @override
  Theme build(BuildContext context){
    return Theme(
      data: MainDialogTheme.build(context),
      child: AlertDialog(
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
      )
    );
  }
}