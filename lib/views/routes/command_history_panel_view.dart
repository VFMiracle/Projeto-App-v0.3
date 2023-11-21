import 'package:flutter/material.dart';
import 'package:projeto_time_counter/models/routes/command_history_panel_model.dart';
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
        title: const Text("Command History"),
      ),
      body: Consumer<CommandHistoryPanelHistoriesNotifier>(
        builder: (BuildContext context, CommandHistoryPanelHistoriesNotifier historiesNotifier, Widget? child){
          if(historiesNotifier.qtdHistories > 0){
            return _buildCommandHistoryList();
          }else{
            return _buildNoCommandHistoryMessage();
          }
        }
      )
    );
  }

  Widget _buildCommandHistoryList(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index){
              return CommandHistoryView(model: CommandHistoryPanelModel().historiesNotifier.getHistoryByIndex(index));
            },
            itemCount: CommandHistoryPanelModel().historiesNotifier.qtdHistories,
            separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 2.5)
          ),
        ),
      ]
    );
  }

  Center _buildNoCommandHistoryMessage(){
    return Center(
      child: Text(
        "No Commands were Performed on the Time Records Today",
        style: Theme.of(context).textTheme.headlineMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}