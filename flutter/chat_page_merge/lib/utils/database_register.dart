import 'package:flutter/material.dart';
import '/utils/register_chat_table.dart';
import '/utils/register_action_table.dart';
import '/widget/chat_fukidashi.dart';
import '/widget/chat_todo.dart';

// チャットオブジェクトを描画するクラスなのでまずはクラス設計にしましょう
class DataBaseRegister {
// TODO:は修正、やってほしいところを示しています。タスクが終わればそのコメントを削除してください
// できるだけ直接値を記述するのではなく変数を作ってその中に文字列は真偽値を入れて作成しましょう

// この関数はチャットオブジェクトを表示する
// 引数にbool型のisTodo,String型のchatText,bool型のisUser,String型のmainTag,String型のstartTime,bool型のisActionFlagを設定する
// この関数を動かすために絶対に必要なものだけrequiredをつける。それ以外にrequiredをつけると問題が発生するのですべてにrequiredをつけないでください。
// つまり↑のコメントで提示してあるrequiredをつけるべき引数はisTodo,chatText,isUserです。
  dynamic drawChatObjects({
    required bool isTodo, // ←のように引数を定義
    required String chatText,
    required bool isUser,
    String? mainTag, // ？は引数で呼び出さなくても許される型
    String? startTime,
    bool? isActionFlag,
  }) {
    // 今のままだと空文字でチャットが登録されてしまうのでif文でチェックをする
    if (chatText.isEmpty) {
      return;
    } 

    // if文の場所に問題があったので変えました
    // ↓のif文はトグルボタンがオンの時にアクションが表示される
    if (isTodo) {
      ChatTodo message = ChatTodo(
          title: chatText,
          isSentByUser: isUser,
          mainTag: mainTag ?? '',
          startTime: startTime ?? '',
          actionFinished: isActionFlag ?? false);
      return message;
    }

    // isTodoはトグルボタンの状態を受け取る
    // このif文はメッセージを送信したいので()の中はisUserで良い
    if (isUser) {
      // 変数に代入してメッセージをを表示する
      ChatMessage message = ChatMessage(
          text: chatText,
          isSentByUser: isUser);
      return message; // 返り値でmessageを返す
    } else {
      // elseは返答を送信しているので同じものを記述
      // ＊その場合返答はしないようになるので注意(送信のみのチャットになる)
      ChatMessage message = ChatMessage(
        text: chatText, 
        isSentByUser: isUser);
      return message;
    }
  }

  // 送信ボタンを押下したときに呼び出される関数
  // 引数にいろいろ定義
  // TextEditingControllerはテキストフィールドの型です

  dynamic sendButtonPressed(
    String chatText, 
    bool isTodo,
    TextEditingController controller, 
    bool isUser) {
      String myMainTag = '生活';
      String sendTime = DateTime.now().toString();
      bool actionFlag = false;
    // チャットをデータベースに登録する
    // ↓のようにインスタンス生成して下さい
    RegisterChatTable registerChatTable = RegisterChatTable(
        chatSender: true,
        chatTodo: isTodo,
        chatMessage: chatText,
        chatTime: sendTime);
    registerChatTable.registerChatTableFunc(); //ここは確定で呼び出す

    //トグルボタンがオンの時だけ呼び出す
    if (isTodo) {
      RegisterActionTable registerActionTable = RegisterActionTable(
        actionName: chatText, 
        actionStart: sendTime,
        actionMainTag: myMainTag,
        actionState: actionFlag,
      );
      registerActionTable.registerActionTableFunc();
    }
    // テキストフィールドをクリア
    controller.clear();

    // 吹き出し及びアクションの表示
    // 吹き出しクラスの引数を受け取れるように変更する
    // コメントアウト削除のショートカットキー
    // コメントされてる範囲を囲んで ctrl + /
    // mainTagを引数に追加して表示
    return drawChatObjects(
      isTodo: isTodo,
      chatText: chatText,
      isUser:  isUser,
      mainTag: myMainTag,
      startTime: sendTime,
      isActionFlag: false
    );
  }
}
