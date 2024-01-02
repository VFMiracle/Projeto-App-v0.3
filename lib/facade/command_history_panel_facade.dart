import 'package:projeto_time_counter/dao/command_history_dao.dart';
import 'package:projeto_time_counter/dto/command_history_dto.dart';
import 'package:projeto_time_counter/enums/command_history_type.dart';

class CommandHistoryPanelFacade{

  void testing() async {
    List<CommandHistoryDTO> dtos = await CommandHistoryDAO().readDbEntriesByCommandType(CommandHistoryType.cronometerEditing.id);
    print(dtos);
  }
}