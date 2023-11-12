import 'package:flutter/material.dart';
import 'package:projeto_time_counter/dto/time_editor_dto.dart';
import 'package:projeto_time_counter/exception/time_record_panel/task_already_recorded_exception.dart';
import 'package:projeto_time_counter/models/time_record_model.dart';
import 'package:projeto_time_counter/models/time_record_panel_model.dart';
import 'package:projeto_time_counter/services/builder/time_editor_builder.dart';
import 'package:projeto_time_counter/utils/date_time_utils.dart';
import 'package:projeto_time_counter/views/reusable/exception_dialog_view.dart';
import 'package:projeto_time_counter/views/time_record_view.dart';
import 'package:projeto_time_counter/views/reusable/time_editor_view.dart';
import 'package:provider/provider.dart';

class TimeRecordPanelView extends StatefulWidget{
  
  const TimeRecordPanelView({Key? key}) : super(key: key);

  @override
  State<TimeRecordPanelView> createState() => _TimeRecordPanelViewState();
}

class _TimeRecordPanelViewState extends State<TimeRecordPanelView>{

  @override
  void dispose(){
    TimeRecordPanelModel.disposeInstance();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
            ),
            onPressed: () => showDialog(
              builder: _buildTimeRecordCreator,
              context: context
            ).then((dynamic result){
              if(result != null){
                TimeEditorDTO editorDto = result as TimeEditorDTO;
                try{
                  TimeRecordPanelModel().timeRecordsNtfr.addTimeRecord(editorDto);
                }on TaskAlreadyRecordedException catch(tare){
                  showDialog(
                    builder: (BuildContext context) => ExceptionDialogView(tare.message),
                    context: context,
                  );
                }
              }
            }),
          ),
          Consumer<TimeRecordPanelSelectedDateNotifier>(
            builder: _buildDateSelector,
          ),
        ],
        title: const Text("Time Records"),
      ),
      body: Consumer<TimeRecordPanelRecordsNotifier>(
        builder: (BuildContext context, TimeRecordPanelRecordsNotifier timeRecordsNtfr, Widget? child){
          if(timeRecordsNtfr.qtdTimeRecords > 0){
            return _buildTimeRecordList(context, timeRecordsNtfr, child);
          }
          return _buildNoTimeRecordsMessage();
        }
      ),
    );
  }

  TextButton _buildDateSelector(BuildContext context, TimeRecordPanelSelectedDateNotifier selDateNtfr, Widget? child){
    return TextButton(
      onPressed: () => showDialog<DateTime>(
        context: context,
        builder: _buildTimeRecordDatePickerDialog,
      ).then((DateTime? newDate){
        if(newDate != null){
          selDateNtfr.changeDate(newDate);
        }
      }),
      child: Text(
        DateTimeUtils().mapDateToDisplayString(selDateNtfr.selDate),
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }

  Widget _buildNoTimeRecordsMessage(){
    return Center(
      child: Text(
        "There aren't any Time Records for this day.",
        style: Theme.of(context).textTheme.headlineMedium,
        textAlign: TextAlign.center,
      ),
    );
  }

  TimeEditorView _buildTimeRecordCreator(BuildContext context){
    return TimeEditorBuilder().buildWithTextField(
      title: "Time Record Creator",
      textFieldLabelName: "Task Name",
      allowEmptyTextField: false,
      allowTimeZero: false,
    );
  }

  DatePickerDialog _buildTimeRecordDatePickerDialog(BuildContext context){
    return DatePickerDialog(
      firstDate: DateTime(2023),
      initialDate: TimeRecordPanelModel().selDateNtfr.selDate,
      lastDate: DateTime.now(),
    );
  }

  ListView _buildTimeRecordList(BuildContext context, TimeRecordPanelRecordsNotifier timeRecordsNtfr, Widget? child){
    return ListView.separated(
      itemBuilder: (BuildContext context, int index){
        TimeRecordModel timeRecordModel = timeRecordsNtfr.getRecordByIndex(index);
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: timeRecordModel.countedTimeNtfr),
            ChangeNotifierProvider.value(value: timeRecordModel.taskNameNtfr),
          ],
          child: TimeRecordView(timeRecordModel: timeRecordModel),
        );
      },
      itemCount: timeRecordsNtfr.qtdTimeRecords,
      separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 2.5),
    );
  }
}