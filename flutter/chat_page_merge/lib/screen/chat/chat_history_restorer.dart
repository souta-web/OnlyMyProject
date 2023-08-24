import '/utils/database_helper.dart';
import '/widget/chat_todo.dart';
import '/widget/chat_fukidashi.dart';

// チャット履歴を復元するクラス
class ChatHistoryRestorer {
  // アプリ起動時に呼び出される復元メソッド
  static Future<void> restoreChatHistory(List<dynamic> messages) async {
    final db = await DatabaseHelper.instance.database;

    // チャットメッセージをデータベースから取得
    final List<Map<String, dynamic>>? chat_table_message = await db?.query(
      'chat_table',
      columns: [
        'chat_todo', // チャットメッセージの種類（true: アクション, false: ユーザー）
        'chat_message', // メッセージテキスト
      ],
    );

    // アクションテーブルからアクション情報を取得
    final List<Map<String, dynamic>>? action_table_message = await db?.query(
      'action_table',
      columns: [
        'action_name',
        'action_main_tag',
        'action_start',
      ],
    );

    var action_index = 0; // アクションテーブルのインデックス

    if (chat_table_message != null) {
      // チャットメッセージごとにループ
      for (final row in chat_table_message) {
        final chat_table_todo = row['chat_todo'];
        final chat_table_message_text = row['chat_message'];

        // アクションメッセージかつアクションテーブルにまだ要素が残っている場合
        if (chat_table_todo == "true" &&
            action_index < action_table_message!.length) {
          final action_table_name =
              action_table_message[action_index]['action_name'];
          final action_table_maintag =
              action_table_message[action_index]['action_main_tag'];
          final action_table_start =
              action_table_message[action_index]['action_start'];

          // ChatTodoオブジェクトを作成してメッセージリストに追加
          messages.add(ChatTodo(
              title: action_table_name,
              isSentByUser: false, // アクションメッセージはユーザーからのものではないのでfalseに設定
              mainTag: action_table_maintag,
              startTime: action_table_start,
              actionFinished: false));

          action_index++; // 次のアクション移るためにインデックスを増やす
        } else {
          // ユーザーメッセージの場合はユーザーからのメッセージとして追加
          if (chat_table_todo == "false") {
            // TODO: AI側の返答が復元時に送信メッセージと同じ値になるのでそれを修正する
            messages.add(ChatMessage(
              text: chat_table_message_text,
              isSentByUser: true, // ユーザーからのメッセージなのでtrueに設定
            ));
          } else if (chat_table_todo == "true") {
            messages.add(ChatMessage(
              text: chat_table_message_text,
              isSentByUser: false, // AIからのメッセージなのでfalseに設定
            ));
            action_index++;
          }
        }
      }
    }
  }
}
