import 'package:flutter/material.dart';
import 'package:projeto_time_counter/models/widgets/reusable/command_history_model.dart';
import 'package:projeto_time_counter/utils/date_time_utils.dart';
import 'package:projeto_time_counter/views/widgets/reusable/deletion_dialog_view.dart';

class CommandHistoryView extends StatelessWidget{
  final CommandHistoryModel _model;

  const CommandHistoryView({required CommandHistoryModel model, Key? key}) : _model = model, super(key: key);

  @override
  Widget build(BuildContext context){
    return TextButton(
      onPressed: () => showDialog(
        builder: (BuildContext context) => DeletionDialogView(
          "Are you sure about deleting this history?",
          _model.delete,
        ),
        context: context,
      ),
      child: _buildHistoryContent(context),
    );
  }

  Table _buildHistoryContent(BuildContext context){
    String updateInfoText = "";
    if(_model.updateInfo != null){
      if(_model.updateInfo.runtimeType != String){
        updateInfoText = _model.updateInfo.toString();
      }else{
        updateInfoText = _model.updateInfo;
      }
    }
    return Table(
      children: [
        TableRow(
          children: [
            Text(
              _model.commandName,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              DateTimeUtils().mapDateToDisplayString(_model.creationDate),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.secondary
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
        TableRow(
          children: [
            Text(
              _model.targetName,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              updateInfoText,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.right,
            )
          ],
        ),
      ]
    );
  }
}