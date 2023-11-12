import 'package:flutter/material.dart';
import 'package:projeto_time_counter/models/cronometer_model.dart';
import 'package:projeto_time_counter/services/time_conversion_service.dart';
import 'package:projeto_time_counter/views/cronometer_view.dart';
import 'package:provider/provider.dart';

class CronometerPanelEntryView extends StatefulWidget{
  final CronometerModel _crnmtrModel;

  const CronometerPanelEntryView({required CronometerModel crnmtrModel, Key? key}) : _crnmtrModel = crnmtrModel, super(key: key);

  @override
  State<CronometerPanelEntryView> createState() => CronometerPanelEntryViewState();
}

class CronometerPanelEntryViewState extends State<CronometerPanelEntryView>{
  
  @override
  TextButton build(BuildContext context){
    return TextButton(
      onLongPress: () => showDialog(
        context: context,
        builder: (BuildContext context) => _buildCrnmtrDeletionDialog(context),
      ),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
          return MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: widget._crnmtrModel.isRunningNtfr),
              ChangeNotifierProvider.value(value: widget._crnmtrModel.nameNtfr),
              ChangeNotifierProvider.value(value: widget._crnmtrModel.valueNtfr),
            ],
            child: CronometerView(crnmtrModel: widget._crnmtrModel),
          );
        })
      ),
      child: _buildEntryContent(),
    );
  }

  AlertDialog _buildCrnmtrDeletionDialog(BuildContext context){
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: (){
            widget._crnmtrModel.delete();
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
          )
        ),
      ],
      title: Text(
        "Are you sure you want to delete the ${widget._crnmtrModel.nameNtfr.name} Cronometer?",
      )
    );
  }

  Table _buildEntryContent(){
    return Table(
      children: [
        TableRow(
          children:[
            ChangeNotifierProvider.value(
              value: widget._crnmtrModel.nameNtfr,
              child: Consumer<CronometerNameNotifier>(
                builder: (BuildContext context, CronometerNameNotifier crnmtrNameNtfr, Widget? child) => Text(crnmtrNameNtfr.name),
              ),
            ),
            ChangeNotifierProvider.value(
              value: widget._crnmtrModel.isRunningNtfr,
              child: Consumer<CronometerIsRunningNotifier>(
                builder: (BuildContext context, CronometerIsRunningNotifier crnmtrIsRnngNtfr, Widget? child){
                  return Text(
                    crnmtrIsRnngNtfr.isRunning ? "" : "Paused",
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Theme.of(context).colorScheme.secondary)
                  );
                }
              ),
            ),
          ]
        ),
        TableRow(
          children:[
            ChangeNotifierProvider.value(
              value: widget._crnmtrModel.valueNtfr,
              child: Consumer<CronometerValueNotifier>(
                builder: (BuildContext context, CronometerValueNotifier crnmtrValueNtfr, Widget? child){
                  return Text(
                    TimeConversionService().fromIntToString(crnmtrValueNtfr.currentValue),
                    style: TextStyle(color: Theme.of(context).colorScheme.secondary)
                  );
                }
              ),
            ),
            const Text(
              "",
              textAlign: TextAlign.end,
            )
          ]
        ),
      ]
    );
  }
}