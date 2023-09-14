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
    final chatHistory =
        await dbHelper.queryAllRows_chat_table(); // データベースからチャット履歴を取得する

    print(chatHistory);

    final drawChatObjects = DrawChatObjects(); // チャットメッセージをウィジェットに変換する

    // チャット履歴を処理してウィジェットを生成し、_messagesに追加する
    for (var chat in chatHistory) {
      //chatHistoryの中身は辞書型で帰ってくるから下の三行のような形で値取得する。あと、型の宣言は必ずしてください。
      final bool isTodo = chat['chat_todo'] == "true" ? true : false;
      final String chatText = chat['chat_message'] ?? "";
      final bool isUser = chat['chat_sender'] == "0" ? true : false;
      final String mainTag = chat['mainTag'] ?? "";
      final String startTime = chat['chat_time'] ?? "";
      final bool isActionFinished =
          chat['chat_todofinish'] == "0" ? true : false;

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
