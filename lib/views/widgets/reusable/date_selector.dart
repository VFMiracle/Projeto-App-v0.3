import 'package:flutter/material.dart';
import 'package:projeto_time_counter/models/widgets/reusable/sel_date_notifier.dart';
import 'package:projeto_time_counter/utils/date_time_utils.dart';

class DateSelector extends StatefulWidget{
  final SelDateNotifier _selDateNotifier;

  const DateSelector._internal(SelDateNotifier selDateNotifier, { Key? key }): _selDateNotifier = selDateNotifier, super(key: key);

  static DateSelector build(BuildContext context, SelDateNotifier selDateNotifier, Widget? child){
    return DateSelector._internal(selDateNotifier);
  }

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector>{

  @override
  Widget build(BuildContext context){
    return TextButton(
      onPressed: () => showDialog(
        builder: _buildDatePickerDialog,
        context: context,
      ).then((newDate){
        if(newDate != null){
          widget._selDateNotifier.selDate = newDate;
        }
      }),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.only(right: 10)),
      ),
      child: Text(
        DateTimeUtils().mapDateToDisplayString(widget._selDateNotifier.selDate),
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
          fontSize: 18
        ),
        /*style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)*/
      ),
    );
  }

  DatePickerDialog _buildDatePickerDialog(BuildContext context){
    return DatePickerDialog(
      firstDate: DateTime(2023),
      initialDate: widget._selDateNotifier.selDate,
      lastDate: DateTime.now(),
    );
  }
}