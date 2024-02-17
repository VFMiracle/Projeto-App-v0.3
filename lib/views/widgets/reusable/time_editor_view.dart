import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:projeto_time_counter/enums/time_unit.dart';
import 'package:projeto_time_counter/exception/time_editor/no_text_field_text_exception.dart';
import 'package:projeto_time_counter/exception/time_editor/time_value_is_zero_exception.dart';
import 'package:projeto_time_counter/models/widgets/reusable/time_editor_model.dart';
import 'package:projeto_time_counter/views/widgets/reusable/exception_dialog_view.dart';
import 'package:provider/provider.dart';

class TimeEditorView extends StatefulWidget{
  final String _title;
  final String? _textFieldLabelName;
  final TimeEditorModel _model;

  const TimeEditorView({required String title, String? textFieldLabelName, required TimeEditorModel model, Key? key}) : _title = title,
      _textFieldLabelName = textFieldLabelName, _model = model, super(key: key);

  @override
  State<TimeEditorView> createState() => TimeEditorViewState();
}

class TimeEditorViewState extends State<TimeEditorView>{

  @override
  AlertDialog build(BuildContext context){
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () => _submitEditor(context),
          child: Text(
            "Submit",
            style: TextStyle(color: Theme.of(context).colorScheme.secondary)
          ),
        ),
      ],
      actionsPadding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
      content: _buildContent(context),
      contentPadding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      title: Text(
        widget._title,
      ),
      titlePadding: const EdgeInsets.fromLTRB(30, 15, 30, 5),
    );
  }

  Column _buildContent(BuildContext context){
    List<Widget> contentWidgets = [
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTimeUnitPicker(context, TimeUnit.hour),
            const Text(":"),
            _buildTimeUnitPicker(context, TimeUnit.minute),
            const Text(":"),
            _buildTimeUnitPicker(context, TimeUnit.second),
          ],
        ),
      ),
    ];

    if(widget._textFieldLabelName != null){
      TextEditingController textEdtngCtrlr = TextEditingController(text: widget._model.textFieldText);
      textEdtngCtrlr.addListener(() => widget._model.textFieldText = textEdtngCtrlr.text);
      contentWidgets.insert(0, Row(
        children: [
          Text("${widget._textFieldLabelName}: "),
          Expanded(
            child: TextField(
              controller: textEdtngCtrlr,
              style: Theme.of(context).dialogTheme.contentTextStyle,
            ),
          ),
        ]
      ));
    }

    Column content = Column(
      mainAxisSize: MainAxisSize.min,
      children: contentWidgets,
    );
    return content;
  }

  Widget _buildTimeUnitPicker(BuildContext context, TimeUnit timeUnit){
    return ChangeNotifierProvider.value(
      value: widget._model.getTimeUnitNotifier(timeUnit),
      child: Consumer<TimeEditorTimeUnitNotifier>(
        builder: (BuildContext context, TimeEditorTimeUnitNotifier timeUnitNtfr, Widget? child){
          return NumberPicker(
            infiniteLoop: true,
            itemHeight: 30,
            itemWidth: 70,
            maxValue: timeUnit.valueToGreaterUnit - 1,
            minValue: 0,
            onChanged: (int newValue) => widget._model.getTimeUnitNotifier(timeUnit).value = newValue,
            selectedTextStyle: Theme.of(context).textTheme.headlineMedium,
            textStyle: Theme.of(context).textTheme.headlineSmall,
            value: widget._model.getTimeUnitNotifier(timeUnit).value,
            zeroPad: true,
          );
        }
      )
    );
  }

  void _submitEditor(BuildContext context){
    try{
      widget._model.validateExitProcess();
      Navigator.pop(context, widget._model.getTimeEditorDTO());
    } on TimeValueIsZeroException catch(te){
      showDialog(
        builder: (BuildContext context) => ExceptionDialogView(te.message),
        context: context,
      );
    } on NoTextFieldTextException catch(ne){
      showDialog(
        builder: (BuildContext context) => ExceptionDialogView(ne.message),
        context: context,
      );
    }
  }
}