import 'package:flutter/material.dart';
import 'package:projeto_time_counter/models/routes/cronometer_panel_model.dart';
import 'package:projeto_time_counter/views/widgets/cronometer_panel_entry_view.dart';
import 'package:projeto_time_counter/views/widgets/reusable/exception_dialog_view.dart';
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
          _buildSearchBar(),
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
    TextEditingController nameEditingController = TextEditingController();
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: (){
            if(nameEditingController.text.isNotEmpty){
              CronometerPanelModel().addCronometer(nameEditingController.text);
              Navigator.of(context).pop();
            }else{
              showDialog(
                builder: (BuildContext context) => const ExceptionDialogView("A Cronometer can't have an empty name. Please provide a valid string."),
                context: context,
              );
            }
          },
          child: const Text("Create"),
        ),
      ],
      content: TextField(controller: nameEditingController),
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
        textAlign: TextAlign.center,
      ),
    );
  }

  Container _buildSearchBar(){
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                color: Theme.of(context).colorScheme.onPrimary,
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
  }
}