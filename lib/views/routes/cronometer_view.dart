import 'package:flutter/material.dart';
import 'package:projeto_time_counter/background/background_cronometer.dart';
import 'package:projeto_time_counter/models/routes/cronometer_model.dart';
import 'package:projeto_time_counter/services/time_conversion_service.dart';
import 'package:projeto_time_counter/themes/cronometer_theme.dart';
import 'package:provider/provider.dart';

//DESC: Represents the visual blueprint for a Cronometer.
class CronometerView extends StatefulWidget{
  final BackgroundCronometer _bkgrndCrnmtr;
  final CronometerModel _model;
  final CronometerTheme _theme = CronometerTheme();

  CronometerView({required CronometerModel crnmtrModel, Key? key}) : _model = crnmtrModel, _bkgrndCrnmtr = BackgroundCronometer(crnmtrModel), super(key: key);

  @override
  State<CronometerView> createState() => _CronometerViewState();
}

class _CronometerViewState extends State<CronometerView> with WidgetsBindingObserver{

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    if(state == AppLifecycleState.paused){
      widget._bkgrndCrnmtr.start();
    }else if(state == AppLifecycleState.resumed){
      widget._bkgrndCrnmtr.cancel();
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.create_sharp),
            onPressed: () => showDialog(
              context: context,
              builder: _buildNameEditingDialog,
            ),
          ),
        ],
        title: Consumer<CronometerNameNotifier>(
          builder: (BuildContext context, CronometerNameNotifier crnmtrNameNtfr, Widget? child) => Text(crnmtrNameNtfr.name)
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Consumer<CronometerValueNotifier>(
                builder: (BuildContext context, CronometerValueNotifier crnmtrValueNtfr, Widget? child){
                  return Text(
                    TimeConversionService().fromIntToString(crnmtrValueNtfr.currentValue),
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: widget._theme.crnmtrCounterColor,
                    ),
                  );
                }
              ),
            ),
          ),
          Container(
            color: Theme.of(context).colorScheme.onBackground,
            padding: const EdgeInsets.symmetric(vertical: 12.5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer<CronometerIsRunningNotifier>(
                  builder: (BuildContext context, CronometerIsRunningNotifier crnmtrIsRnngNtfr, Widget? child) =>
                    _buildCountOptionButtons(crnmtrIsRnngNtfr.isRunning, widget._model.valueNtfr.currentValue)
                ),
              ],
            )
          ),
        ],
      ),
    );
  }

  Row _buildCountOptionButtons(bool isRunning, int crnmtrValue){
    String pauseBtnText;
    Color selPauseBtnColor;
    Widget? resetButton;
    
    if(!isRunning){
      selPauseBtnColor = widget._theme.continueBtnTextColor;
      if(crnmtrValue > 0){
        pauseBtnText = "Continue";
        resetButton = TextButton(
          //OBS: Both of the 'press' events are called with a 'setState' to make sure the Bottom App Bar is rebuilt and properly updated when the Cronometer Value is
          //  reset since it doesn't listen to changes to the Cronometer's Value.
          onLongPress: () => setState(() => widget._model.resetValue(false)),
          onPressed: () => setState(() => widget._model.resetValue(true)),
          style: TextButton.styleFrom(
            foregroundColor: widget._theme.resetBtnTextColor,
            textStyle: Theme.of(context).textTheme.displayMedium
          ),
          child: const Text("Reset"),
        );
      }else{
        pauseBtnText = "Start";
      }
    }else{
      pauseBtnText = "Pause";
      selPauseBtnColor = Theme.of(context).colorScheme.secondary;
    }

    List<Widget> children = [
      TextButton(
        onPressed: (){
          widget._model.toggleIsRunning();
        },
        style: TextButton.styleFrom(
          foregroundColor: selPauseBtnColor,
          textStyle: Theme.of(context).textTheme.displayMedium
        ),
        child: Text(pauseBtnText),
      ),
    ];
    if(resetButton != null){
      children.add(resetButton);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }

  AlertDialog _buildNameEditingDialog(BuildContext context){
    TextEditingController nameEdtngCtrlr = TextEditingController(text: widget._model.nameNtfr.name);
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: (){
            widget._model.nameNtfr.name = nameEdtngCtrlr.text;
            Navigator.of(context).pop();
          },
          child: Text(
            "Submit",
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
      ],
      content: TextField(controller: nameEdtngCtrlr),
      title: const Text("Name Editor")
    );
  }
}