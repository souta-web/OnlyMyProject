import 'package:chat_page_merge/utils/database_helper.dart';
import 'package:flutter/material.dart';

import '/widget/chat_fukidashi.dart';
import '/widget/chat_todo.dart';
import '/utils/register_chat_table.dart';
import '/utils/register_action_table.dart';

// トグルボタンの状態によってオブジェクトを表示する
class DrawChatObjects {
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

  // 連続してチャットが送信できるように新しいメッセージを読み込むメソッド
  void _loadChatMessages(List<dynamic> messages) async {
    final dbHelper = DatabaseHelper.instance;
    final chats = await dbHelper.queryAllRows_chat_table();

    messages.clear();
    chats.forEach((chat) {
      messages.add(ChatMessage(
        text: chat[DatabaseHelper.columnChatMessage],
        isSentByUser: chat[DatabaseHelper.columnChatSender] == 0,
      ));
    });
  }

  // 送信ボタンが押されたときに呼び出される
  sendButtonPressed(String chatText, bool isTodo, List<dynamic> messages,
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
      if (isTodo) {
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
        print("アクションが登録されました: ");
        print(messages);
      }
    }
    return drawChatObjects(chatText, messages, controller);
  }
}
