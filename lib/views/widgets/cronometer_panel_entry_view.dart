import 'package:flutter/material.dart';
import 'package:projeto_time_counter/models/routes/cronometer_model.dart';
import 'package:projeto_time_counter/services/time_conversion_service.dart';
import 'package:projeto_time_counter/views/routes/cronometer_view.dart';
import 'package:projeto_time_counter/views/widgets/reusable/deletion_dialog_view.dart';
import 'package:provider/provider.dart';

class CronometerPanelEntryView extends StatefulWidget{
  final CronometerModel _cronometerModel;

  const CronometerPanelEntryView({required CronometerModel cronometerModel, Key? key}) : _cronometerModel = cronometerModel, super(key: key);

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
          "Are you sure you want to delete the ${widget._cronometerModel.nameNotifier.name} Cronometer?",
          widget._cronometerModel.delete
        ),
      ),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
          return MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: widget._cronometerModel.isRunningNotifier),
              ChangeNotifierProvider.value(value: widget._cronometerModel.nameNotifier),
              ChangeNotifierProvider.value(value: widget._cronometerModel.valueNotifier),
            ],
            child: CronometerView(crnmtrModel: widget._cronometerModel),
          );
        })
      ),
      child: _buildEntryContent(),
    );
  }

  Widget _buildEntryContent(){
    return ChangeNotifierProvider.value(
      value: widget._cronometerModel.isRunningNotifier,
      child: Consumer<CronometerIsRunningNotifier>(
        builder: (BuildContext context, CronometerIsRunningNotifier isRunningNotifier, Widget? child){
          TextStyle runningStyle = Theme.of(context).textTheme.labelLarge!.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 22
          );
          
          List<Row> content = [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                ChangeNotifierProvider.value(
                  value: widget._cronometerModel.nameNotifier,
                  child: Consumer<CronometerNameNotifier>(
                    builder: (BuildContext context, CronometerNameNotifier nameNotifier, Widget? child) => Text(
                      nameNotifier.name,
                      style: isRunningNotifier.isRunning ? runningStyle : null
                    ),
                  ),
                ),
                const Spacer(flex: 8),
                ChangeNotifierProvider.value(
                  value: widget._cronometerModel.valueNotifier,
                  child: Consumer<CronometerValueNotifier>(
                    builder: (BuildContext context, CronometerValueNotifier valueNotifier, Widget? child) => Text(
                      TimeConversionService().fromIntToString(valueNotifier.currentValue),
                      style: isRunningNotifier.isRunning ? runningStyle : null
                    )
                  ),
                ),
                const Spacer(),
              ]
            ),
          ];

          return Column(
            children: content,
          );
        }
      ),
    );

    /* return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ChangeNotifierProvider.value(
              value: widget._cronometerModel.nameNotifier,
              child: Consumer<CronometerNameNotifier>(
                builder: (BuildContext context, CronometerNameNotifier crnmtrNameNtfr, Widget? child) => Text(crnmtrNameNtfr.name),
              ),
            ),
            ChangeNotifierProvider.value(
              value: widget._cronometerModel.valueNotifier,
              child: Consumer<CronometerValueNotifier>(
                builder: (BuildContext context, CronometerValueNotifier crnmtrValueNtfr, Widget? child){
                  return Text(
                    TimeConversionService().fromIntToString(crnmtrValueNtfr.currentValue),
                  );
                }
              ),
            ),
          ]
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChangeNotifierProvider.value(
              value: widget._cronometerModel.isRunningNotifier,
              child: Consumer<CronometerIsRunningNotifier>(
                builder: (BuildContext context, CronometerIsRunningNotifier crnmtrIsRnngNtfr, Widget? child){
                  return Text(
                    crnmtrIsRnngNtfr.isRunning ? "" : "Paused",
                  );
                }
              ),
            ),
          ]
        ),
      ]
    ); */

    /* return Table(
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
              value: widget._crnmtrModel.valueNotifier,
              child: Consumer<CronometerValueNotifier>(
                builder: (BuildContext context, CronometerValueNotifier crnmtrValueNtfr, Widget? child){
                  return Text(
                    TimeConversionService().fromIntToString(crnmtrValueNtfr.currentValue),
                    textAlign: TextAlign.end,
                  );
                }
              ),
            ),
          ]
        ),
        TableRow(
          children:[
            ChangeNotifierProvider.value(
              value: widget._crnmtrModel.isRunningNotifier,
              child: Consumer<CronometerIsRunningNotifier>(
                builder: (BuildContext context, CronometerIsRunningNotifier crnmtrIsRnngNtfr, Widget? child){
                  return Text(
                    crnmtrIsRnngNtfr.isRunning ? "" : "Paused",
                    textAlign: TextAlign.center,
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
    ); */
  }
}