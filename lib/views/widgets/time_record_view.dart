import 'package:flutter/material.dart';
import 'package:projeto_time_counter/models/widgets/time_record_model.dart';
import 'package:projeto_time_counter/services/builder/time_editor_builder.dart';
import 'package:projeto_time_counter/services/time_conversion_service.dart';
import 'package:projeto_time_counter/views/widgets/reusable/time_editor_view.dart';
import 'package:provider/provider.dart';

class TimeRecordView extends StatelessWidget{
  final TimeRecordModel _model;

  const TimeRecordView({required TimeRecordModel timeRecordModel, Key? key}) : _model = timeRecordModel, super(key: key);

  @override
  Widget build(BuildContext context){
    return TextButton(
      onLongPress: (){
        showDialog(builder: _buildDeletionDialog, context: context);
      },
      onPressed: () => showDialog(
        builder: _buildRecordEditor,
        context: context,
      ).then((dynamic result){
        if(result != null){
          _model.update(result);
        }
      }),
      child: Column(
        children: [
          Center(
            child: Consumer<TimeRecordTaskNameNotifier>(
              builder: (BuildContext context, TimeRecordTaskNameNotifier taskNameNtfr, Widget? child){
                return Text(
                  taskNameNtfr.taskName,
                  style: Theme.of(context).textTheme.bodyMedium,
                );
              },
            ),
          ),
          Center(
            child: Consumer<TimeRecordCountedTimeNotifier>(
              builder:(BuildContext context, TimeRecordCountedTimeNotifier countedTimeNtfr, Widget? child){
                return Text(
                  TimeConversionService().fromIntToString(countedTimeNtfr.countedTime),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                );
              },
            )
          ),
        ],
      ),
    );
  }

  AlertDialog _buildDeletionDialog(BuildContext context){
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: (){
            _model.delete();
            Navigator.of(context).pop();
          },
          child: Text(
            "Yes",
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "No",
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
      ],
      title: const Text("Do you wish to delete this Time Record?"),
    );
  }

  TimeEditorView _buildRecordEditor(BuildContext context){
    return TimeEditorBuilder().buildWithTextField(
      title: "Time Record Editor",
      textFieldLabelName: "Task Name",
      intlTextFieldText: _model.taskNameNtfr.taskName,
      intlTimeUnitValues: TimeConversionService().fromIntToTimeUnitValues(_model.countedTimeNtfr.countedTime),
      allowEmptyTextField: false,
      allowTimeZero: false,
    );
  }
}