import 'package:flutter/material.dart';

class DateSelector extends StatefulWidget{
  final ChangeNotifier _selDateNotifier;

  DateSelector({required ChangeNotifier selDateNotifier, Key? key}): _selDateNotifier = selDateNotifier, super(key: key);

  @override
  State<DateSelector> createState() => DateSelectorState();
}

class DateSelectorState extends State<DateSelector>{

  @override
  build(BuildContext context){
    return Text("Something");
  }

  DatePickerDialog _buildCommandHistoryDatePickerDialog(BuildContext context){
    return DatePickerDialog(
      firstDate: DateTime(2023),
      initialDate: widget._selDateNotifier.selDate,
      lastDate: DateTime.now(),
    );
  }
}