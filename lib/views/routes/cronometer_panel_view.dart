import 'package:flutter/material.dart';
import 'package:projeto_time_counter/models/routes/cronometer_panel_model.dart';
import 'package:projeto_time_counter/views/widgets/cronometer_panel_entry_view.dart';
import 'package:provider/provider.dart';

//Represents the visual blueprint for the Cronometer Panel.
class CronometerPanelView extends StatefulWidget{

  const CronometerPanelView({Key? key}) : super(key: key);

  @override
  State<CronometerPanelView> createState() => _CronometerPanelViewState();
}

class _CronometerPanelViewState extends State<CronometerPanelView>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => showDialog(
              context: context,
              builder: _buildCronometerCreatorDialog,
            ),
          ),
        ],
        title: const Text("Cronometer Panel")
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /*_buildSearchBar(),*/
          Expanded(
            child: Consumer<CronometerPanelModel>(
              builder: (BuildContext context, CronometerPanelModel cronometerPanelModel, Widget? child){
                if(cronometerPanelModel.qtdCronometer > 0){
                  return _buildCronometerList();
                }
                return _buildNoCronometerMessage();
              }
            ),
          ),
        ],
      ),
    );
  }

  AlertDialog _buildCronometerCreatorDialog(BuildContext context){
    TextEditingController cronometerNameEdtngCtrlr = TextEditingController();
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: (){
            if(cronometerNameEdtngCtrlr.text.isNotEmpty){
              CronometerPanelModel().addCronometer(cronometerNameEdtngCtrlr.text);
              Navigator.of(context).pop();
            }
          },
          child: const Text(
            "Create",
            /*style: Theme.of(context).textTheme.displaySmall,*/
          ),
        ),
      ],
      content: TextField(
        controller: cronometerNameEdtngCtrlr,
        /*style: Theme.of(context).dialogTheme.contentTextStyle*/
      ),
      title: const Text("Cronometer Creator"),
    );
  }

  ListView _buildCronometerList(){
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) => CronometerPanelEntryView(cronometerModel: CronometerPanelModel().getCronometerModelByIndex(index)),
      itemCount: CronometerPanelModel().qtdCronometer,
      separatorBuilder: (BuildContext context, int index) => const Divider()
    );
  }

  Center _buildNoCronometerMessage(){
    return const Center(
      child: Text(
        "There are no Cronometers to display.",
        /*style: Theme.of(context).textTheme.headlineMedium,*/
        textAlign: TextAlign.center,
      ),
    );
  }

  /*Container _buildSearchBar(){
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 15, offset: Offset(0, -2.5))],
        color: Color.fromARGB(255, 51, 157, 211),
      ),
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, right: 15),
            child: const Icon(Icons.search),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                color: Color.fromARGB(255, 41, 102, 133),
                shape: BoxShape.rectangle,
              ),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search for a Cronometer",
                  hintStyle: TextStyle(color: Color.fromARGB(255, 30, 58, 71)),
                ),
                onChanged: null,
                /*style: TextStyle(color: Colors.white),*/
              ),
            ),
          ),
        ]
      ),
    );
  }*/
}