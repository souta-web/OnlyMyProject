import 'package:flutter/material.dart';

import '/utils/database_helper.dart';
import '/utils/draw_chat_objects.dart';

// アプリ起動時のチャット履歴復元を行う
class RestoreChatHistory {
  late List<Widget> _messages = []; // チャットメッセージを格納するリスト

  // データベースからチャット履歴を取得し、それをウィジェットとして_messagesリストに追加するためのメソッド
  Future<void> fetchChatHistory() async {
    // データベースからチャット履歴を取得する
    final dbHelper = DatabaseHelper.instance;
    final chatHistory = await dbHelper.queryAllRows_chat_table(); // データベースからチャット履歴を取得する

    final drawChatObjects = DrawChatObjects(); // チャットメッセージをウィジェットに変換する

    // チャット履歴を処理してウィジェットを生成し、_messagesに追加する
    for (var chat in chatHistory) {
      final isTodo = chat[DatabaseHelper.columnChatTodo] == 'true' ? true : false;
      final chatText = chat[DatabaseHelper.columnChatMessage] as String;
      final isUser = chat[DatabaseHelper.columnChatSender] == 'true';

      final mainTag = chat[DatabaseHelper.columnActionMainTag] as String?;
      final startTime = chat[DatabaseHelper.columnChatTime] as String?;
      final isActionFinished =
          chat[DatabaseHelper.columnChatTodofinish] == 'false';

      final chatObject = drawChatObjects.createChatObjects(
        isTodo: isTodo,
        chatText: chatText,
        isUser: isUser,
        mainTag: mainTag,
        startTime: startTime,
        isActionFinished: isActionFinished,
      );

      // ウィジェットが正常に生成された場合、リストに追加
      if (chatObject != null) {
        _messages.add(chatObject);
      }
    }
  }

  // _messagesリストを返す。これを呼び出すことで取得したチャット履歴の
  // ウィジェットが外部からアクセス可能になる
  List<Widget> getMessages() {
    return _messages;
  }
}
