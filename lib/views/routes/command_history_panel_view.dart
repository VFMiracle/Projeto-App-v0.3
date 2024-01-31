import 'package:flutter/material.dart';
import 'package:projeto_time_counter/enums/command_history_type.dart';
import 'package:projeto_time_counter/models/routes/command_history_panel_model.dart';
import 'package:projeto_time_counter/utils/date_time_utils.dart';
import 'package:projeto_time_counter/views/widgets/command_history_view.dart';
import 'package:provider/provider.dart';

class CommandHistoryPanelView extends StatefulWidget{
  
  const CommandHistoryPanelView({Key? key}): super(key: key);

  @override
  State<CommandHistoryPanelView> createState() => CommandHistoryPanelViewState();
}

class CommandHistoryPanelViewState extends State<CommandHistoryPanelView>{

  @override
  void dispose(){
    CommandHistoryPanelModel.disposeInstance();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<CommandHistoryPanelSelDateNotifier>(
            builder: _buildDateSelector,
          )
        ],
        title: const Text("Command History")
      ),
      body: Column(
        children: [
          _buildCommandHistoryTypeDropdownSection(context),
          Expanded(
            child: Consumer<CommandHistoryPanelHistoriesNotifier>(
              builder: (BuildContext context, CommandHistoryPanelHistoriesNotifier historiesNotifier, Widget? child){
                if(historiesNotifier.qtdHistories > 0){
                  return _buildCommandHistoryList(context);
                }else{
                  return _buildNoCommandHistoryMessage(context);
                }
              }
            )
          ),
        ],
      ),
    );
  }

  DatePickerDialog _buildCommandHistoryDatePickerDialog(BuildContext context){
    return DatePickerDialog(
      firstDate: DateTime(2023),
      initialDate: CommandHistoryPanelModel().selDateNotifier.selDate,
      lastDate: DateTime.now(),
    );
  }

  Widget _buildCommandHistoryList(BuildContext context){
    return ListView.separated(
      itemBuilder: (BuildContext context, int index){
        return CommandHistoryView(model: CommandHistoryPanelModel().historiesNotifier.getHistoryByIndex(index));
      },
      itemCount: CommandHistoryPanelModel().historiesNotifier.qtdHistories,
      separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 2.5)
    );
  }

  Container _buildCommandHistoryTypeDropdownSection(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Displaying the History for: ",
            style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).colorScheme.background),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.only(left: 5),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<CommandHistoryType>(
                iconEnabledColor: Theme.of(context).colorScheme.background,
                items: CommandHistoryType.values.map<DropdownMenuItem<CommandHistoryType>>(
                  (CommandHistoryType type) => DropdownMenuItem<CommandHistoryType>(
                    value: type,
                    child: Text(
                      type.description,
                      style: TextStyle(color: Theme.of(context).colorScheme.primary)
                    )
                  ),
                ).toList(),
                onChanged: (CommandHistoryType? newHistoryType) => setState(() => CommandHistoryPanelModel().historiesNotifier.selCommandHistoryType = newHistoryType!),
                selectedItemBuilder: (BuildContext context) => CommandHistoryType.values.map<Widget>(
                  (CommandHistoryType type) => Container(
                    alignment: Alignment.center,
                    child: Text(
                      type.description,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).colorScheme.background),
                    )
                  ),
                ).toList(),
                value: CommandHistoryPanelModel().historiesNotifier.selCommandHistoryType,
              )
            ),
          ),
        ]
      )
    );
  }

  TextButton _buildDateSelector(BuildContext context, CommandHistoryPanelSelDateNotifier selDateNotifier, Widget? child){
    return TextButton(
      onPressed: () => showDialog(
        builder: _buildCommandHistoryDatePickerDialog,
        context: context,
      ).then((newDate){
        if(newDate != null){
          selDateNotifier.selDate = newDate;
        }
      }),
      child: Text(
        DateTimeUtils().mapDateToDisplayString(selDateNotifier.selDate),
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)
      ),
    );
  }

  Center _buildNoCommandHistoryMessage(BuildContext context){
    return Center(
      child: Text(
        "There aren't any registered Commands of this Type on this day.",
        style: Theme.of(context).textTheme.headlineMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}