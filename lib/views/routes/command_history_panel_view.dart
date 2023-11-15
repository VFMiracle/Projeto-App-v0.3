import 'package:flutter/material.dart';

class CommandHistoryPanelView extends StatefulWidget{
  
  const CommandHistoryPanelView({Key? key}): super(key: key);

  @override
  State<CommandHistoryPanelView> createState() => CommandHistoryPanelViewState();
}

class CommandHistoryPanelViewState extends State<CommandHistoryPanelView>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Command History"),
      ),
      body: 1 > 0 ? _buildCommandHistoryList() : _buildNoCommandHistoryMessage(),
    );
  }

  Widget _buildCommandHistoryList(){
    return const Text("Nada");
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