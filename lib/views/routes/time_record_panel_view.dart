import 'package:flutter/material.dart';
import 'package:projeto_time_counter/dto/time_editor_dto.dart';
import 'package:projeto_time_counter/exception/time_record_panel/task_already_recorded_exception.dart';
import 'package:projeto_time_counter/models/widgets/time_record_model.dart';
import 'package:projeto_time_counter/models/routes/time_record_panel_model.dart';
import 'package:projeto_time_counter/services/builder/time_editor_builder.dart';
import 'package:projeto_time_counter/views/widgets/reusable/date_selector.dart';
import 'package:projeto_time_counter/views/widgets/reusable/exception_dialog_view.dart';
import 'package:projeto_time_counter/views/widgets/time_record_view.dart';
import 'package:projeto_time_counter/views/widgets/reusable/time_editor_view.dart';
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
                  TimeRecordPanelModel().timeRecordsNotifier.addTimeRecord(editorDto);
                }on TaskAlreadyRecordedException catch(tare){
                  showDialog(
                    builder: (BuildContext context) => ExceptionDialogView(tare.message),
                    context: context,
                  );
                }
              }
            }),
          ),
          Consumer<TimeRecordPanelSelDateNotifier>(
            builder: DateSelector.build,
          ),
        ],
        title: const Text("Time Records"),
      ),
      body: Consumer<TimeRecordPanelRecordsNotifier>(
        builder: (BuildContext context, TimeRecordPanelRecordsNotifier timeRecordsNotifier, Widget? child){
          if(timeRecordsNotifier.qtdTimeRecords > 0){
            return _buildTimeRecordList(context, timeRecordsNotifier, child);
          }
          return _buildNoTimeRecordsMessage(context);
        }
      ),
    );
  }

  Center _buildNoTimeRecordsMessage(BuildContext context){
    return const Center(
      child: Text(
        "There aren't any Time Records for this day.",
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

  ListView _buildTimeRecordList(BuildContext context, TimeRecordPanelRecordsNotifier timeRecordsNtfr, Widget? child){
    return ListView.separated(
      itemBuilder: (BuildContext context, int index){
        TimeRecordModel timeRecordModel = timeRecordsNtfr.getRecordByIndex(index);
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: timeRecordModel.countedTimeNotifier),
            ChangeNotifierProvider.value(value: timeRecordModel.taskNameNotifier),
          ],
          child: TimeRecordView(timeRecordModel: timeRecordModel),
        );
      },
      itemCount: timeRecordsNtfr.qtdTimeRecords,
      separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 2.5),
    );
  }
}