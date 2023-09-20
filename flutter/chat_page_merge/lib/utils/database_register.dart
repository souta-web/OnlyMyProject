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
// 済 TODO: dynamicの配列を動かすので関数の型はdynamicにしてください(型定義は必須)
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
    if (chatText.isNotEmpty) {
      // isNotEmptyは空文字を許さないよっていう条件
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
    // 済 TODO: ()の中身をisUserに修正
    if (isUser) {
      // 変数に代入してメッセージをを表示する
      ChatMessage message = ChatMessage(
          text: chatText,
          isSentByUser: isUser);
      return message; // 返り値でmessageを返す
    } else {
      // elseは返答を送信しているので同じものを記述
      // TODO: 上記と同じものを記述する、返り値も忘れずに。
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
    // TODO: メインタグに文字列を格納する変数を作る(String型)
    // 例　String myMainTag = 'ゲーム';
      //String myMainTag = '生活';
    // TODO: 送信時間を格納する変数を作る(String型)　DateTime.now().toString()を使う
      String sendTime = DateTime.now().toString();
    // TODO: アクションの状態を管理する変数を作る(bool型)、今はテストなので初期値はfalseでOKです
      //bool actionFlag = false;
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
        // TODO: actionStartの次にactionMainTag,actionStateを作成
        // TODO: actionNameにはchatText、actionStartに↑で作成した送信時間の変数を記述
        // TODO: actionMainTagには↑で作ったmainTag用の変数をいれる
        // TODO: actionStateには↑で作ったアクションの状態を管理する変数を記述
        actionName: chatText, 
        actionStart: sendTime,
        //actionMainTag: myMainTag,
        //actionState: actionFlag,
      );
      registerActionTable.registerActionTableFunc(); // TODO: インスタンス生成した変数.registerActionTableFunc()の形にする
    }
    // テキストフィールドをクリア
    controller.clear();

    // 吹き出し及びアクションの表示
    // 吹き出しクラスの引数を受け取れるように変更する
    // 今のままだとエラーが出るのでコメントアウトしときます
    // 全てのタスクが終わってこの関数を動かすときにコメントアウトを削除してください
    // コメントアウト削除のショートカットキー
    // コメントされてる範囲を囲んで ctrl + /

    return drawChatObjects(
      isTodo: isTodo, // TODO: isTodoを記述
      chatText: chatText, // TODO: chatTextを記述
      isUser:  isUser, // TODO: isUserを記述
      startTime: sendTime,  // TODO: 送信時間用の変数記述
      isActionFlag: false// TODO: ここはfalseで記述お願いします。
    );
  }
}
