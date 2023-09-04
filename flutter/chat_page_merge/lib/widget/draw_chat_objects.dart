import 'package:flutter/material.dart';

import '/widget/chat_fukidashi.dart';
import '/widget/chat_todo.dart';
import '/utils/register_chat_table.dart';
import '/utils/register_action_table.dart';

// トグルボタンの状態によってオブジェクトを表示する
class DrawChatObjects {
  final bool _isTodo; // _isTodoを格納するフィールドを追加

  // コンストラクタを追加して_isTodoを受け取れるようにする
  DrawChatObjects(this._isTodo);

  // チャットオブジェクトを表示する
  void drawChatObjects(String chatText, List<dynamic> messages,
      TextEditingController controller) {
    // テキストフィールドが空でないかチェック
    if (controller.text.isNotEmpty) {
      ChatMessage userMessage =
          ChatMessage(text: chatText, isSentByUser: true); // 応答側のメッセージ

      // テキスト入力をクリアする
      controller.clear();

      // チャットメッセージをリストの先頭に追加
      messages.add(userMessage);
    }
  }

  // 送信ボタンが押されたときに呼び出される
  sendButtonPressed(String chatText, List<dynamic> messages,
      TextEditingController controller) {

    if (controller.text.isNotEmpty) {
      // チャットをデータベースに登録する
      RegisterChatTable registerChatTable = RegisterChatTable(
        chatSender: 'John',
        chatMessage: chatText,
      );
      registerChatTable.registerChatTableFunc(); // 実際にデータベースに登録
      print("チャットが送信されました");

      // トグルボタンがオンの時アクションを登録する
      if (_isTodo) {
        RegisterActionTable registerActionTable = RegisterActionTable(
          actionName: 'ゲーム',
          actionStart: DateTime.now().toString(),
        );
        registerActionTable.registerActionTableFunc();
        // アクションを作成する
        ChatTodo actionMessage = ChatTodo(
            title: chatText,
            isSentByUser: false,
            mainTag: "#趣味",
            startTime: DateTime.now().toString(),
            actionFinished: false);

        messages.add(actionMessage);
        controller.clear();
        print("アクションが登録されました");
      }
    }
    return drawChatObjects(chatText, messages, controller);
  }
}
