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
            color: Colors.white,
            icon: const Icon(Icons.add),
            onPressed: () => showDialog(
              context: context,
              builder: _buildCrnmtrCrtrDialog,
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
            child: _buildCrnmtrList(),
          ),
        ],
      ),
    );
  }

  AlertDialog _buildCrnmtrCrtrDialog(BuildContext context){
    TextEditingController crnmtrNameEdtngCtrlr = TextEditingController();
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: (){
            if(crnmtrNameEdtngCtrlr.text.isNotEmpty){
              CronometerPanelModel().addCronometer(crnmtrNameEdtngCtrlr.text);
              Navigator.of(context).pop();
            }
          },
          child: Text(
            "Create",
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
      ],
      content: TextField(controller: crnmtrNameEdtngCtrlr),
      title: const Text("Cronometer Creator"),
    );
  }

  Consumer<CronometerPanelModel> _buildCrnmtrList(){
    return Consumer<CronometerPanelModel>(
      builder: (BuildContext context, CronometerPanelModel crnmtrPanelModel, Widget? child){
        if(crnmtrPanelModel.qtdCrnmtrs > 0){
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) => CronometerPanelEntryView(crnmtrModel: CronometerPanelModel().getCrnmtrModelByIndex(index)),
            itemCount: CronometerPanelModel().qtdCrnmtrs,
            separatorBuilder: (BuildContext context, int index) => const Divider()
          );
        }else{
          return Center(
            child: Text(
              "There are no Cronometers to display.",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          );
        }
      }
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
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ]
      ),
    );
  }*/
}