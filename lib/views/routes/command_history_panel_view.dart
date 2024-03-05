import 'package:flutter/material.dart';
import 'package:projeto_time_counter/enums/command_history_type.dart';
import 'package:projeto_time_counter/models/routes/command_history_panel_model.dart';
import 'package:projeto_time_counter/views/widgets/command_history_view.dart';
import 'package:projeto_time_counter/views/widgets/reusable/date_selector.dart';
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
            builder: DateSelector.build,
          )
        ],
        title: Text(
          "Command History",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 28
          ),
        )
      ),
      body: Column(
        children: [
          _buildCommandHistoryTypeDropdownSection(context),
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                textTheme: Theme.of(context).textTheme.copyWith(
                  labelLarge: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              child: Consumer<CommandHistoryPanelHistoriesNotifier>(
                builder: (BuildContext context, CommandHistoryPanelHistoriesNotifier historiesNotifier, Widget? child){
                  if(historiesNotifier.qtdHistories > 0){
                    return _buildCommandHistoryList(context);
                  }else{
                    return _buildNoCommandHistoryMessage(context);
                  }
                }
              )
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
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            width: 150,
            child: Text(
              "Displaying the History for: ",
            )
          ),
          //INFO: Flutter recommendes using the Dropdown Menu Widget as a subtitute for Dropdown Button on Material 3 Projects. For one reason or another, this Project used
          //  the latter Widget, and since it's on it's final changes of this iteration, changing the Widget completly feels unnecessary. If this Project recieves another
          //  iteration of changes, this Widget will be modified.
          DropdownButtonHideUnderline(
            child: DropdownButton<CommandHistoryType>(
              dropdownColor: Theme.of(context).colorScheme.secondary,
              items: CommandHistoryType.values.map<DropdownMenuItem<CommandHistoryType>>(
                (CommandHistoryType type) => DropdownMenuItem<CommandHistoryType>(
                  value: type,
                  child: Text(
                    type.description,
                    style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
                  )
                ),
              ).toList(),
              onChanged: (CommandHistoryType? newHistoryType) => setState(() => CommandHistoryPanelModel().historiesNotifier.selCommandHistoryType = newHistoryType!),
              selectedItemBuilder: (BuildContext context) => CommandHistoryType.values.map<Widget>(
                (CommandHistoryType type) => Container(
                  alignment: Alignment.center,
                  child: Text(
                    type.description,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onSecondary),
                  )
                ),
              ).toList(),
              value: CommandHistoryPanelModel().historiesNotifier.selCommandHistoryType,
            )
          ),
        ]
      )
    );
  }

  Center _buildNoCommandHistoryMessage(BuildContext context){
    return const Center(
      child: Text(
        "There aren't any registered Commands of this Type on this day.",
        textAlign: TextAlign.center,
      ),
    );
  }
}