import 'dart:typed_data';

//import 'package:flutter/material.dart';

import '/utils/database_helper.dart';
import 'draw_chat_objects.dart';
import '/utils/text_formatter.dart';

// アプリ起動時のチャット履歴復元を行う
class RestoreChatHistory {
  final List<dynamic> _messages = []; // チャットメッセージを格納するリスト

  // データベースからチャット履歴を取得し、それをウィジェットとして_messagesリストに追加するためのメソッド
  Future<void> fetchChatHistory() async {
    final DatabaseHelper dbHelper = DatabaseHelper.instance;
    final List<Map<String, dynamic>> chatHistory =
        await dbHelper.queryAllRows_chat_table(); // データベースからチャット履歴を取得する
    final List<Map<String, dynamic>> actionHistory =
        await dbHelper.queryAllRows_action_table(); // データベースからアクションを取得する
    final List<Map<String, dynamic>> mediaHistory =
        await dbHelper.queryAllRows_media_table(); // データベースから画像を取得する

    DrawChatObjects drawChatObjects =
        DrawChatObjects(); // チャットメッセージをウィジェットに変換する
    TextFormatter timeFormatter = TextFormatter();

    // カラムから取得する必要があるデータを格納する変数を宣言
    late bool _isTodo;
    late String _chatText;
    late bool _isUser;
    late String _mainTag;
    late String _startTime;
    late bool _isActionFinished;
    late List<Uint8List> _mediaData;

    // チャット履歴を処理してウィジェットを生成し、_messagesと_actionsに追加する
    for (var chat in chatHistory) {
      //chatHistoryの中身は辞書型で帰ってくるから下の三行のような形で値取得する。あと、型の宣言は必ずしてください。
      _isTodo = chat['chat_todo'] == "true" ? true : false;
      _chatText = chat['chat_message'] ?? "null";
      _isUser = chat['chat_sender'] == "true" ? true : false;
      _startTime = chat['chat_time'] ?? "null";

      late String drawTime = timeFormatter.returnHourMinute(_startTime);
      // アクションテーブルからデータを取得し、mainTag,isActionFinished を取得
      if (actionHistory != <String, dynamic>{} && actionHistory.isNotEmpty) {
        final Map<String, dynamic> actionData = actionHistory.firstWhere(
          (action) => action['action_id'] != action['action_chat_id'],
          orElse: () => <String, dynamic>{}, // 空のマップを返す,
        );
        _mainTag = actionData['action_main_tag'] ?? "null";
        _isActionFinished = actionData['action_end'] == "true" ? true : false;
      }

      // メディア情報を初期化
      _mediaData = [];

      // メディア情報を取得
      if (mediaHistory.isNotEmpty) {
        late Map<String, dynamic> mediaRow = mediaHistory.firstWhere((media) {
          return media['media_table_name'] == 'chat_table' &&
              media['media_table_id'] == chat['chat_id'];
        }, orElse: () => <String, dynamic>{});

        if (mediaRow != <String, dynamic>{}) {
          for (int i = 1; i <= 4; i++) {
            final String columnName = 'media_0$i';
            if (mediaRow.containsKey(columnName)) {
              final media = Uint8List.fromList(mediaRow[columnName]);
              _mediaData.add(media);
            }
          }
        }
      }
      final dynamic chatObject = drawChatObjects.createChatObjects(
        isTodo: _isTodo,
        chatText: _chatText,
        isUser: _isUser,
        mainTag: _mainTag,
        startTime: drawTime,
        isActionFinished: _isActionFinished,
        imageList: _mediaData,
      );

      // ウィジェットが正常に生成された場合、リストに追加
      if (chatObject != null) {
        if (_isTodo) {
          _messages.add(chatObject);
        } else {
          // チャットの場合、_messagesリストに追加
          _messages.add(chatObject);
        }
      }
    }
  }

  // _messagesリストを返す。これを呼び出すことで取得したチャット履歴の
  // ウィジェットが外部からアクセス可能になる
  List<dynamic> getMessages() {
    return _messages;
  }
}
