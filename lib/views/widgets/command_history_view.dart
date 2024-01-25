import 'package:flutter/material.dart';
import 'package:projeto_time_counter/models/widgets/reusable/command_history_model.dart';
import 'package:projeto_time_counter/models/widgets/time_record_editing_ch_model.dart';
import 'package:projeto_time_counter/utils/date_time_utils.dart';
import 'package:projeto_time_counter/views/widgets/reusable/deletion_dialog_view.dart';

class CommandHistoryView extends StatelessWidget{
  final CommandHistoryModel _model;

  const CommandHistoryView({required CommandHistoryModel model, Key? key}) : _model = model, super(key: key);

  @override
  Widget build(BuildContext context){
    return TextButton(
      onLongPress: () => showDialog(
        builder: (BuildContext context) => DeletionDialogView(
          "Are you sure about deleting this history?",
          _model.delete,
        ),
        context: context,
      ),
      onPressed: (){},
      child: _buildHistoryContent(context),
    );
  }

  Widget _buildHistoryContent(BuildContext context){
    String headerText = DateTimeUtils().mapDateTimeToDisplayString(_model.creationDateTime, shouldDisplaySeconds: true);
    List<Widget> columnContent = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headerText,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            _model.commandName,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
      Row(
        children: [Text(
          (_model is TimeRecordEditingChModel ? "Target Time Record: " : "Target Cronometer: ") + _model.targetName,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w500),
        )]
      ),
    ];
    if(_model.updateInfo != null){
      columnContent.add(Row(children: [
        Text(
          _model.writeUpdateInfoDisplayString(),
          style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w500),
        )
      ]));
    }
    return Column(children: columnContent);
  }
}