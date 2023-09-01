import 'package:flutter/material.dart';

import '/widget/chat_fukidashi.dart';
import '/widget/chat_todo.dart';
import '/utils/register_chat_table.dart';
import '/utils/register_action_table.dart';

// トグルボタンの状態によってオブジェクトを表示する
class DrawChatObjects {
  // トグルボタンの状態によってオブジェクトを表示する
  void drawChatObjects(String chattext, List<dynamic> messages,
      TextEditingController controller, bool isTodo) {
    // テキストフィールドが空でないかチェック
    if (controller.text.isNotEmpty) {
      ChatMessage userMessage =
          ChatMessage(text: chattext, isSentByUser: true); // 応答側のメッセージ

      // テキスト入力をクリアする
      controller.clear();

      // チャットメッセージをリストの先頭に追加
      messages.add(userMessage);
    }

    // スイッチの状態を引数で受け取る
    if (isTodo) {
      // アクションを作成する
      ChatTodo actionMessage = ChatTodo(
          title: chattext,
          isSentByUser: false,
          mainTag: "#趣味",
          startTime: DateTime.now().toString(),
          actionFinished: false);

      controller.clear();
      messages.add(actionMessage);
    }
  }

  sendButtonPressed(String chattext, List<dynamic> messages,
      TextEditingController controller) {
    bool _isTodo = true;
    // チャットをデータベースに登録する
    RegisterChatTable registerChatTable = RegisterChatTable(
      chatSender: 'John',
      chatMessage: chattext,
    );
    registerChatTable.registerChatTableFunc(); // 実際にデータベースに登録

    // トグルボタンがオンの時
    if (_isTodo) {
      String time = DateTime.now().toString();
      RegisterActionTable registerActionTable = RegisterActionTable(
        actionName: 'ゲーム',
        actionStart: time,
      );
      registerActionTable.registerActionTableFunc();
    }
    return drawChatObjects(chattext, messages, controller, _isTodo);
  }
}
