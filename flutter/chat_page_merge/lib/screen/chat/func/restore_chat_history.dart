import '/utils/draw_chat_objects.dart';

class RestoreChatHistory {
  // データベースからチャット履歴を復元する関数
  List<dynamic> restoreChatHistoryFromDatabase() {
    List<dynamic> chatHistory = [];

    // データベースからchat_table, action_table, tag_tableから必要なデータを取得する
    // 以下は仮のコードで、実際のデータベース操作に合わせて修正する必要があります
    List<Map<String, dynamic>> chatTableData = fetchChatTableData();
    List<Map<String, dynamic>> actionTableData = fetchActionTableData();
    List<Map<String, dynamic>> tagTableData = fetchTagTableData();

    // chat_tableのデータを元にチャット履歴を復元する
    for (var chatData in chatTableData) {
      String chatMessage = chatData['chat_message'];
      bool isTodo = chatData['chat_todo']; // データベースからisTodoを取得する処理（仮のコード）
      bool isUser = chatData['chat_sender'];// データベースからisUserを取得する処理（仮のコード）
      String mainTag = chatData['action_data'];// データベースからmainTagを取得する処理（仮のコード）
      String startTime = chatData['sendTime']; // データベースからsendTimeを取得

      // チャットオブジェクトを生成してchatHistoryに追加する
      chatHistory.add(DrawChatObjects().createChatObjects(
        isTodo: isTodo,
        chatText: chatMessage,
        isUser: isUser,
        mainTag: mainTag,
        startTime: startTime,
        isActionFinished: false, // アクションが完了していない場合
      ));
    }

    return chatHistory;
  }

  // 仮のデータベース操作関数。実際のデータベース操作に合わせて修正が必要です。
  List<Map<String, dynamic>> fetchChatTableData() {
    // データベースからchat_tableのデータを取得する処理
    return [];
  }

  List<Map<String, dynamic>> fetchActionTableData() {
    // データベースからaction_tableのデータを取得する処理
    return [];
  }

  List<Map<String, dynamic>> fetchTagTableData() {
    // データベースからtag_tableのデータを取得する処理
    return [];
  }
}
