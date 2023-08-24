import '/utils/database_helper.dart';
import '/widget/chat_todo.dart';
import '/widget/chat_fukidashi.dart';

class ChatHistoryRestorer {
  static Future<void> restoreChatHistory(List<dynamic> messages) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>>? chat_table_message = await db?.query(
      'chat_table',
      columns: [
        'chat_todo',
        'chat_message',
      ],
    );

    final List<Map<String, dynamic>>? action_table_message = await db?.query(
      'action_table',
      columns: [
        'action_name',
        'action_main_tag',
        'action_start',
      ],
    );

    var action_index = 0;

    if (chat_table_message != null) {
      for (final row in chat_table_message) {
        final chat_table_todo = row['chat_todo'];
        final chat_table_message_text = row['chat_message'];

        if (chat_table_todo == "true" &&
            action_index < action_table_message!.length) {
          final action_table_name =
              action_table_message[action_index]['action_name'];
          final action_table_maintag =
              action_table_message[action_index]['action_main_tag'];
          final action_table_start =
              action_table_message[action_index]['action_start'];

          messages.add(ChatTodo(
              title: action_table_name,
              isSentByUser: false,
              mainTag: action_table_maintag,
              startTime: action_table_start,
              actionFinished: false));

          action_index++;
        } else {
          messages.add(ChatMessage(
            text: chat_table_message_text,
            isSentByUser: true, // ユーザーからのメッセージなのでtrueに設定
          ));
          messages.add(ChatMessage(
            text: chat_table_message_text,
            isSentByUser: false, // AIからのメッセージなのでfalseに設定
          ));
        }
      }
    }
  }
}
