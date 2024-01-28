import 'package:flutter/material.dart';
import 'package:projeto_time_counter/models/routes/cronometer_model.dart';
import 'package:projeto_time_counter/services/time_conversion_service.dart';
import 'package:projeto_time_counter/views/routes/cronometer_view.dart';
import 'package:projeto_time_counter/views/widgets/reusable/deletion_dialog_view.dart';
import 'package:provider/provider.dart';

class CronometerPanelEntryView extends StatefulWidget{
  final CronometerModel _crnmtrModel;

  const CronometerPanelEntryView({required CronometerModel cronometerModel, Key? key}) : _crnmtrModel = cronometerModel, super(key: key);

  @override
  State<CronometerPanelEntryView> createState() => CronometerPanelEntryViewState();
}

class CronometerPanelEntryViewState extends State<CronometerPanelEntryView>{
  
  @override
  TextButton build(BuildContext context){
    return TextButton(
      onLongPress: () => showDialog(
        context: context,
        builder: (BuildContext context) => DeletionDialogView(
          "Are you sure you want to delete the ${widget._crnmtrModel.nameNotifier.name} Cronometer?",
          widget._crnmtrModel.delete
        ),
      ),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
          return MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: widget._crnmtrModel.isRunningNotifier),
              ChangeNotifierProvider.value(value: widget._crnmtrModel.nameNotifier),
              ChangeNotifierProvider.value(value: widget._crnmtrModel.valueNotifier),
            ],
            child: CronometerView(crnmtrModel: widget._crnmtrModel),
          );
        })
      ),
      child: _buildEntryContent(),
    );
  }

  Table _buildEntryContent(){
    return Table(
      children: [
        TableRow(
          children:[
            ChangeNotifierProvider.value(
              value: widget._crnmtrModel.nameNotifier,
              child: Consumer<CronometerNameNotifier>(
                builder: (BuildContext context, CronometerNameNotifier crnmtrNameNtfr, Widget? child) => Text(crnmtrNameNtfr.name),
              ),
            ),
            ChangeNotifierProvider.value(
              value: widget._crnmtrModel.isRunningNotifier,
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
              value: widget._crnmtrModel.valueNotifier,
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