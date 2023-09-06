import 'package:flutter/material.dart';

import '/widget/chat_fukidashi.dart';
import '/widget/chat_todo.dart';
import '/utils/register_chat_table.dart';
import '/utils/register_action_table.dart';

// トグルボタンの状態によってオブジェクトを表示する
class DrawChatObjects {
  // チャットオブジェクトを表示する
  //受け取れる引数増やせば、アプリ再起動時の履歴復元にも使えるので
  Widget drawChatObjects(String chatText, bool isTodo, bool isUser) {
    if (isTodo) {
      // アクションを作成する
      ChatTodo message = ChatTodo(
          title: chatText,
          isSentByUser: false,
          mainTag: "#趣味",
          startTime: DateTime.now().toString(), //チャットオブジェクトを表示することが目的の関数なので、日時を取得してそれを表示させるのはふさわしくない。引数で受け取るようにする。(辻)
          actionFinished: false);
      return message;

    }else{
      if (isUser) {
        ChatMessage message = ChatMessage(text: chatText, isSentByUser: isUser); // 応答側のメッセージ
        return message;
      }else{
        ChatMessage message = ChatMessage(text: chatText, isSentByUser: isUser); // 返答側のメッセージ
        return message;
      }

    }
    //↓チャットオブジェクトを返す関数の本筋と直接関係のない処理は書き込まないほうが良い。
    //関数は基本的に1つの機能のみを持たせる。今回の場合はチャットオブジェクトを作ること＆コントローラーのクリアの2つの機能が含まれることになるから良くない。
    //controller.clear();
  }

  // 送信ボタンが押されたときに呼び出される
  //引数にisUser追加(辻)
  sendButtonPressed(String chatText, bool isTodo, 
      TextEditingController controller, bool isUser) {
    controller.clear();
    if (chatText.isNotEmpty) {
      // チャットをデータベースに登録する
      RegisterChatTable registerChatTable = RegisterChatTable(
        chatSender: '0',
        chatMessage: chatText,
      );
      registerChatTable.registerChatTableFunc(); // 実際にデータベースに登録
      print("チャットが送信されました");

      // トグルボタンがオンの時アクションを登録する
      if (isTodo) {
        RegisterActionTable registerActionTable = RegisterActionTable(
          actionName: chatText,
          actionStart: DateTime.now().toString(),
        );
        registerActionTable.registerActionTableFunc();
      }
      //messages.add(chatText);
      // 吹き出し及びアクションの表示
      
    }
    return drawChatObjects(chatText, isTodo ,isUser);
  }
}
