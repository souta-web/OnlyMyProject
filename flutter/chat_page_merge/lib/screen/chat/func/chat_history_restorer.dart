import '/utils/database_helper.dart';
import '/widget/chat_fukidashi.dart'; 
import '/widget/chat_todo.dart'; 

class ChatHistoryRestorer {
  static Future<void> restoreChatHistory(List<dynamic> messages) async {
    final db = await DatabaseHelper.instance.database;

    final chatMessages = await db?.query(
      DatabaseHelper.chat_table,
      columns: [
        DatabaseHelper.columnChatSender,
        DatabaseHelper.columnChatTodo,
        DatabaseHelper.columnChatMessage,
        DatabaseHelper.columnChatTime,
        DatabaseHelper.columnChatActionId,
      ],
    );

    final actionMessages = await db?.query(
      DatabaseHelper.action_table,
      columns: [
        DatabaseHelper.columnActionName,
        DatabaseHelper.columnActionState,
        DatabaseHelper.columnActionStart,
        DatabaseHelper.columnActionMainTag,
      ],
    );

    var actionIndex = 0;

    if (chatMessages != null) {
      for (final row in chatMessages) {
        final chatSender = row[DatabaseHelper.columnChatSender] as String;
        final chatTodo = row[DatabaseHelper.columnChatTodo] as String;
        final chatMessage = row[DatabaseHelper.columnChatMessage] as String;
        // final chatTime = row[DatabaseHelper.columnChatTime] as String;
        // final chatActionId = row[DatabaseHelper.columnChatActionId] as int;

        if (chatTodo == 'true') {
          final actionName = actionMessages?[actionIndex][DatabaseHelper.columnActionName] as String;
          final actionStartTime = actionMessages?[actionIndex][DatabaseHelper.columnActionStart] as String;
          final actionMainTag = actionMessages?[actionIndex][DatabaseHelper.columnActionMainTag] as String;

          messages.add(ChatTodo(
            title: actionName,
            isSentByUser: false,
            mainTag: actionMainTag,
            startTime: actionStartTime,
            actionFinished: false,
          ));

          actionIndex++;
        } else {
          messages.add(ChatMessage(
            text: chatMessage,
            isSentByUser: chatSender == 0,
          ));
        }
      }
    }
  }
}
