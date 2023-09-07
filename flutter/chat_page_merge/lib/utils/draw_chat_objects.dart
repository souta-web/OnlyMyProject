import 'package:flutter/material.dart';

import '/widget/chat_fukidashi.dart';
import '/widget/chat_todo.dart';
import 'register_chat_table.dart';
import 'register_action_table.dart';

// トグルボタンの状態によってオブジェクトを表示する
class DrawChatObjects {
  // チャットオブジェクトを表示する
  //受け取れる引数増やせば、アプリ再起動時の履歴復元にも使えるので
  dynamic drawChatObjects({required bool isTodo,
                          required String chatText,
                          required bool isUser,
                          required String mainTag,
                          required String startTime,
                          required bool isActionFinished,}) {

    if (chatText.isEmpty) {
      return ;
    }

    if (isTodo) {
      // アクションを作成する
      ChatTodo message = ChatTodo(title: chatText,
                                  isSentByUser: isUser,
                                  mainTag: mainTag,
                                  startTime:startTime, //チャットオブジェクトを表示することが目的の関数なので、日時を取得してそれを表示させるのはふさわしくない。引数で受け取るようにする。(辻)
                                  actionFinished: isActionFinished);
      return message; 
    }

    if (isUser) {
      ChatMessage message = ChatMessage(text: chatText, isSentByUser: isUser); // 応答側のメッセージ
      return message; 
    } else {
      ChatMessage message = ChatMessage(text: chatText, isSentByUser: isUser); // 返答側のメッセージ
      return message; 
    }
  }

  // 送信ボタンが押されたときに呼び出される
  //引数にisUser追加(辻)
  dynamic sendButtonPressed(String chatText, 
                            bool isTodo,
                            TextEditingController controller, 
                            bool isUser) {
    String sendTime = DateTime.now().toString().toString();//日付取得

    if (chatText.isEmpty) {
      return ;
    }

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
        actionStart: sendTime,
      );
      registerActionTable.registerActionTableFunc();
    }

    controller.clear(); //テキストフィールドのクリア

    // 吹き出し及びアクションの表示
    // 吹き出しクラスの引数を受け取れるように変更
    return drawChatObjects(isTodo: isTodo,
                           chatText: chatText,
                           isUser: isUser,
                           mainTag: '#趣味',
                           startTime: sendTime,
                           isActionFinished: false);
  }
}
