import 'package:projeto_time_counter/enums/time_unit.dart';
import 'package:projeto_time_counter/models/reusable/time_editor_model.dart';
import 'package:projeto_time_counter/services/strategies/time_editor_configuration_strategy.dart';
import 'package:projeto_time_counter/views/reusable/time_editor_view.dart';

class TimeEditorBuilder{

  TimeEditorView build({required String title, Map<TimeUnit, int>? intlTimeUnitValues, bool? allowTimeZero}){
    return TimeEditorView(
      title: title,
      model: TimeEditorModel(
        configStrtg: TimeEditorConfigurationStrategy(
          allowTimeZero: allowTimeZero ?? true,
        )
      )
    );
  }

  TimeEditorView buildWithTextField({required String title, required String textFieldLabelName, String? intlTextFieldText, Map<TimeUnit, int>? intlTimeUnitValues,
      bool? allowTimeZero, bool? allowEmptyTextField}){
    return TimeEditorView(
      title: title,
      textFieldLabelName: textFieldLabelName,
      model: TimeEditorModel(
        configStrtg: TimeEditorConfigurationStrategy(
          allowEmptyTextField: allowEmptyTextField,
          allowTimeZero: allowTimeZero ?? true,
        ),
        intlTimeUnitValues: intlTimeUnitValues,
        textFieldText: intlTextFieldText,
      ),
    );
  }
}