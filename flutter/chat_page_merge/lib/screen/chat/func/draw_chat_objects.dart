import 'dart:typed_data';

import 'package:flutter/material.dart';
import '/widget/chat_fukidashi.dart';
import '/widget/chat_todo.dart';
import '/widget/create_images.dart';
import '/utils/register_chat_table.dart';
import '/utils/register_action_table.dart';
import '/utils/register_media_table.dart';
import '/utils/register_tag_table.dart';
import '/utils/register_tag_setting_table.dart';
import '/utils/register_action_time_table.dart';
import '/utils/register_chat_time_table.dart';
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
      if (imageList.isEmpty) {
        // チャットメッセージの表示
        ChatMessage message = ChatMessage(
            text: "$chatTextを開始", isSentByUser: isUser, time: startTime); // 返答側のメッセージ

        return message;
      } else {
        // 画像を実体化して表示
        CreateImages createImages =
            CreateImages(text: "$chatTextを開始", images: imageList, time: startTime);
        return createImages;
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
    // late String chatActionLinkId =
    //     timeFormatter.returnChatActionLinkId(sendTime);
    String _actionState = 'false';

    if (chatText.isEmpty) {
      return null;
    }

    // 画像データのコピーを保持するための新しいリスト
    // imageBytesリストから画像データをコピーして保持する
    final List<Uint8List> copiedImages = List.from(imageBytes ?? []);
    // チャットをデータベースに登録する
    RegisterChatTable registerChatTable = RegisterChatTable(
      chatSender: 'true',
      chatMessage: chatText,
      chatTodo: isTodo.toString(),
    );
    registerChatTable.registerChatTableFunc(); // 実際にデータベースに登録

    

    // 時間を記録する変数たちを定義
    final int chatYear = DateTime.now().year; // 年を取得
    final int chatMonth = DateTime.now().month; // 月を取得
    final int chatDay = DateTime.now().day; // 日を取得
    final int chatHours = DateTime.now().hour;  // 時を取得
    final int chatMinutes = DateTime.now().minute;  // 分を取得
    final int chatSeconds = DateTime.now().second;  //　秒を取得
    final double lessChatSeconds = DateTime.now().microsecond.toDouble(); // 秒未満を取得
    
    // チャットタイムテーブルデバッグ用
    RegisterChatTimeTable registerChatTimeTable = RegisterChatTimeTable(
    chatId: registerChatTable.chatId,
    chatYear: chatYear,
    chatMonth: chatMonth,
    chatDay: chatDay,
    chatHours: chatHours,
    chatMinutes: chatMinutes,
    chatSeconds: chatSeconds,
    lessChatSeconds: lessChatSeconds,
    );
    registerChatTimeTable.registerChatTimeTableFunc(isTodo);
    
    late RegisterActionTable registerActionTable = RegisterActionTable();

    // トグルボタンがオンの時アクションを登録する
    if (isTodo) {
      registerActionTable = RegisterActionTable(
        actionTitle: chatText,
        actionState: _actionState,
        actionNotes: "あいうえお",
        actionScore: 5,
      );
      registerActionTable.registerActionTableFunc();

      // 時間を記録する変数たちを定義
      final int actionYear = DateTime.now().year; // 年を取得
      final int actionMonth = DateTime.now().month; // 月を取得
      final int actionDay = DateTime.now().day; // 日を取得
      final int actionHours = DateTime.now().hour;  // 時を取得
      final int actionMinutes = DateTime.now().minute;  // 分を取得
      final int actionSeconds = DateTime.now().second;  // 秒を取得
      final double lessActionSeconds = DateTime.now().microsecond.toDouble(); // 秒未満を取得

      // アクションタイムテーブルデバッグ用
      RegisterActionTimeTable registerActionTimeTable = RegisterActionTimeTable(
        actionId: registerActionTable.actionId,
        actionJudgeTime: isTodo.toString(),
        actionYear: actionYear,
        actionMonth: actionMonth,
        actionDay: actionDay,
        actionHours: actionHours,
        actionMinutes: actionMinutes,
        actionSeconds: actionSeconds,
        lessActionSeconds: lessActionSeconds,
      );
      registerActionTimeTable.registerActionTimeTableFunc();

      RegisterTagTable registerTagTable = RegisterTagTable(
      tagName: mainTag,
      tagColor: 1,
      tagIcon: 'デバッグ中',
      );
      registerTagTable.registerTagTableFunc();
      // // タグ設定テーブルデバッグ用
      RegisterTagSettingTable registerTagSettingTable = RegisterTagSettingTable(
        actionId: registerActionTable.actionId,
        tagId: registerTagTable.tagId,
        mainTagFlag: 'false',
        
      );
      registerTagSettingTable.registerTagSettingTableFunc();
    }

    // 画像をメディアテーブルに保存
    if (imageBytes != null && imageBytes.isNotEmpty) {
      for (Uint8List imageByte in imageBytes) {
        RegisterMediaTable registerMediaTable = RegisterMediaTable(
          media: imageByte,
          mediaChatId: registerChatTable.chatId,
          linkActionId: registerActionTable.actionId,
        );
        //print("メディアデータ:$imageBytes");
        registerMediaTable.registerMediaTableFunc();
      }
      // 前回の画像が保持されないようにクリアする
      imageBytes.clear();
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
      imageList: copiedImages,
    );
  }
}
