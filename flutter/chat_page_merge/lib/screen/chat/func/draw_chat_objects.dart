import 'dart:typed_data';

import 'package:flutter/material.dart';
import '/widget/chat_fukidashi.dart';
import '/widget/chat_todo.dart';
import '/widget/create_images.dart';
import '/utils/register_chat_table.dart';
import '/utils/register_action_table.dart';
import '/utils/register_media_table.dart';
import '/utils/text_formatter.dart';

// トグルボタンの状態によってオブジェクトを表示する
class DrawChatObjects {
  // チャットオブジェクトを表示する
  //受け取れる引数増やせば、アプリ再起動時の履歴復元にも使えるので
  //この関数を動かすために絶対に必要なものだけrequiredをつける。それ以外にrequiredをつけると問題が発生するのですべてにrequiredをつけないでください。
  dynamic createChatObjects({
    required bool isTodo,
    required String chatText,
    required bool isUser,
    String? mainTag,
    String? startTime,
    bool? isActionFinished,
    List<Uint8List>? imageList,
  }) {
    imageList ??= [];
    if (chatText.isEmpty) {
      return null;
    }

    // トグルがオンの時に実行
    if (isTodo) {
      // アクションを作成する
      ChatTodo message = ChatTodo(
          title: chatText,
          isSentByUser: isUser,
          mainTag: mainTag ?? "null",
          startTime: startTime ??
              "null", //チャットオブジェクトを表示することが目的の関数なので、日時を取得してそれを表示させるのはふさわしくない。引数で受け取るようにする。(辻)
          actionFinished: isActionFinished ?? false);
      return message;
    }

    // チャットモードの時
    if (isUser) {
      if (imageList.isNotEmpty) {
        // 画像を実体化して表示
        CreateImages createImages =
            CreateImages(text: chatText, images: imageList);
        return createImages;
      } else {
        // チャットメッセージの表示
        ChatMessage message = ChatMessage(
            text: chatText, isSentByUser: isUser, time: startTime); // 返答側のメッセージ

        return message;
      }
    } else {
      ChatMessage message = ChatMessage(
          text: chatText, isSentByUser: isUser, time: startTime); // 返答側のメッセージ

      return message;
    }
  }

  // 送信ボタンが押されたときに呼び出される
  //引数にisUser追加(辻)
  dynamic sendButtonPressed(
      String chatText,
      bool isTodo,
      TextEditingController controller,
      bool isUser,
      List<Uint8List>? imageBytes) {
    String mainTag = '生活';
    String sendTime = DateTime.now().toString(); //日付取得
    TextFormatter timeFormatter = TextFormatter();
    late String drawTime =
        timeFormatter.returnHourMinute(sendTime); //登録時間を表示用にする
    // 送信時間を数値化してchat_action_idとaction_chat_idに登録
    late String chatActionLinkId =
        timeFormatter.returnChatActionLinkId(sendTime);
    String _actionState = 'false';

    if (chatText.isEmpty) {
      return null;
    }

    // チャットをデータベースに登録する
    RegisterChatTable _registerChatTable = RegisterChatTable(
      chatSender: 'true',
      chatMessage: chatText,
      chatTime: sendTime,
      chatTodo: isTodo.toString(),
      chatActionId: chatActionLinkId,
    );
    _registerChatTable.registerChatTableFunc(); // 実際にデータベースに登録
    if (imageBytes != null) {
      RegisterMediaTable _registerMediaTable = RegisterMediaTable(
        media01: imageBytes[0],
        media02: imageBytes[1],
        media03: imageBytes[2],
        media04: imageBytes[3],
      );
      _registerMediaTable.registerMediaTableFunc();
      print('メディアの登録ができました');
    }

    // トグルボタンがオンの時アクションを登録する
    if (isTodo) {
      RegisterActionTable registerActionTable = RegisterActionTable(
        actionName: chatText,
        actionStart: sendTime,
        actionMainTag: mainTag,
        actionState: _actionState,
        actionChatId: chatActionLinkId,
      );
      registerActionTable.registerActionTableFunc();
      
    }

    controller.clear(); //テキストフィールドのクリア

    // 吹き出し及びアクションの表示
    // 吹き出しクラスの引数を受け取れるように変更
    return createChatObjects(
      isTodo: isTodo,
      chatText: chatText,
      isUser: isUser,
      mainTag: mainTag,
      startTime: drawTime,
      isActionFinished: false,
      imageList: imageBytes,
    );
  }
}
