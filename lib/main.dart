import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_time_counter/background/notification_manager.dart';
import 'package:projeto_time_counter/models/routes/command_history_panel_model.dart';
import 'package:projeto_time_counter/models/routes/cronometer_panel_model.dart';
import 'package:projeto_time_counter/models/routes/time_record_panel_model.dart';
import 'package:projeto_time_counter/services/database_initialization_service.dart';
import 'package:projeto_time_counter/themes/main_theme.dart';
import 'package:projeto_time_counter/views/routes/command_history_panel_view.dart';
import 'package:projeto_time_counter/views/routes/cronometer_panel_view.dart';
import 'package:projeto_time_counter/views/routes/time_record_panel_view.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  NotificationManager().startup();

  await DatabaseInitializationService().initialize();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MainMenu());
}

class MainMenu extends StatelessWidget{
  
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context){
    /*ButtonStyle buttonStyle = const ButtonStyle(padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.zero));*/
    
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Time Counter"),
        ),
        body: ListView.separated(
          itemBuilder: (BuildContext context, int index){
            switch(index){
              case 0:{
                return TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                    return ChangeNotifierProvider.value(
                      value: CronometerPanelModel(),
                      child: const CronometerPanelView(),
                    );
                  })),
                  /*style: buttonStyle,*/
                  child: const Text("Cronometer List"),
                );
              }
              case 1:{
                return TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                    //INFO: The Time Record Panel Model should never be initialized at this point in the code execution.
                    return MultiProvider(
                      providers: [
                        ChangeNotifierProvider.value(value: TimeRecordPanelModel().timeRecordsNotifier),
                        ChangeNotifierProvider.value(value: TimeRecordPanelModel().selDateNotifier),
                      ],
                      child: const TimeRecordPanelView(),
                    );
                  })),
                  /*style: buttonStyle,*/
                  child: const Text("Time Records"),
                );
              }
              case 2:{
               return TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return MultiProvider(
                    providers: [
                      ChangeNotifierProvider.value(value: CommandHistoryPanelModel().historiesNotifier),
                      ChangeNotifierProvider.value(value: CommandHistoryPanelModel().selDateNotifier),
                    ],
                    child: const CommandHistoryPanelView(),
                  );
                })),
                child: const Text("Command History Panel"),
               ); 
              }
              default:{
                return null;
              }
            }
          },
          itemCount: 3,
          padding: EdgeInsets.zero,
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        ),
      ),
      theme: MainTheme.build(),
      title: "Time Counter"
    );
  }
}