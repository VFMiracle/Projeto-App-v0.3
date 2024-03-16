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
          "Are you sure you want to delete this Cronometer?",
          widget._cronometerModel.delete,
          content: Text(
            widget._cronometerModel.nameNotifier.name,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
              fontSize: 28,
            )
          ),
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
            color: Theme.of(context).colorScheme.onSecondary,
            fontSize: 26
          );
          
          //INFO: Since the Style of this content only changes when the Cronometer's Running State changes, it only needs an CronometerIsRunning Provider. If it would need
          //  to change when the Value changes or when there's a Reset, then a Notifier should be created for this scenario, if it doesn't exist already, and provided
          //  together with the other Notifier(s).
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
  }
}