import 'package:flutter/material.dart';
import 'package:projeto_time_counter/models/widgets/reusable/command_history_model.dart';

class CommandHistoryView extends StatelessWidget{
  final CommandHistoryModel _model;

  const CommandHistoryView({required CommandHistoryModel model, Key? key}) : _model = model, super(key: key);

  @override
  Widget build(BuildContext context){
    return _buildHistoryContent(context);
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
            Text(_model.commandName),
            Text(_model.creationDate.toString()),
          ],
        ),
        TableRow(
          children: [
            Text(
              _model.targetName,
              textAlign: _model.updateInfo != null ? TextAlign.left : TextAlign.center,
            ),
            Text(updateInfoText)
          ],
        ),
      ]
    );
  }
}