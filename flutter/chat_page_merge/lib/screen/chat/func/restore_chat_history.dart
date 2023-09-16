import 'package:flutter/material.dart';

import '/utils/database_helper.dart';
import '/utils/draw_chat_objects.dart';
import '/utils/text_formatter.dart';

// アプリ起動時のチャット履歴復元を行う
class RestoreChatHistory {
  final List<Widget> _messages = []; // チャットメッセージを格納するリスト

  // データベースからチャット履歴を取得し、それをウィジェットとして_messagesリストに追加するためのメソッド
  Future<void> fetchChatHistory() async {
    final DatabaseHelper dbHelper = DatabaseHelper.instance;
    final List<Map<String, dynamic>> chatHistory =
        await dbHelper.queryAllRows_chat_table(); // データベースからチャット履歴を取得する
    final List<Map<String, dynamic>> actionHistory =
        await dbHelper.queryAllRows_action_table(); // データベースからアクションを取得する

    DrawChatObjects drawChatObjects = DrawChatObjects(); // チャットメッセージをウィジェットに変換する
    TextFormatter timeFormatter = TextFormatter();

    // カラムから取得する必要があるデータを格納する変数を宣言
    late bool _isTodo;
    late String _chatText;
    late bool _isUser;
    late String _mainTag;
    late String _startTime;
    late bool _isActionFinished;

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
        final actionData = actionHistory.firstWhere(
          (action) => action['action_id'] != action['action_chat_id'],
          orElse: () => <String, dynamic>{}, // 空のマップを返す,
        );
        _mainTag = actionData['action_main_tag'] ?? "null";
        _isActionFinished = actionData['action_end'] == "true" ? true : false;
        print('actionData: $actionData');
      }

      final dynamic chatObject = drawChatObjects.createChatObjects(
        isTodo: _isTodo,
        chatText: _chatText,
        isUser: _isUser,
        mainTag: _mainTag,
        startTime: drawTime,
        isActionFinished: _isActionFinished,
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
  List<Widget> getMessages() {
    return _messages;
  }
}
