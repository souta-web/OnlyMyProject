import 'package:flutter/material.dart';

import '/widget/chat_fukidashi.dart';
import '/widget/chat_todo.dart';
import '/utils/register_chat_table.dart';
import '/utils/register_action_table.dart';

// トグルボタンの状態によってオブジェクトを表示する
class DrawChatObjects {
  // チャットオブジェクトを表示する
  void drawChatObjects(String chatText, bool isTodo, List<dynamic> messages,
      TextEditingController controller) {
    ChatMessage userMessage =
        ChatMessage(text: chatText, isSentByUser: true); // 応答側のメッセージ

    // テキスト入力をクリアする
    controller.clear();

    // チャットメッセージをリストの先頭に追加
    messages.add(userMessage);

    if (isTodo) {
      // アクションを作成する
      ChatTodo actionMessage = ChatTodo(
          title: chatText,
          isSentByUser: false,
          mainTag: "#趣味",
          startTime: DateTime.now().toString(),
          actionFinished: false);

      messages.add(actionMessage);
      controller.clear();
    }
  }

  // 送信ボタンが押されたときに呼び出される
  sendButtonPressed(String chatText, bool isTodo, List<dynamic> messages,
      TextEditingController controller) {
    if (chatText.isNotEmpty) {
      // チャットをデータベースに登録する
      RegisterChatTable registerChatTable = RegisterChatTable(
        chatSender: 'John',
        chatMessage: chatText,
      );
      registerChatTable.registerChatTableFunc(); // 実際にデータベースに登録
      print("チャットが送信されました");

      // トグルボタンがオンの時アクションを登録する
      if (isTodo) {
        RegisterActionTable registerActionTable = RegisterActionTable(
          actionName: 'ゲーム',
          actionStart: DateTime.now().toString(),
        );
        registerActionTable.registerActionTableFunc();
      }
      return drawChatObjects(chatText, isTodo, messages, controller);
    }
  }
}
