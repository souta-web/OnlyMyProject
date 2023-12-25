import 'dart:typed_data';

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
    final List<Map<String, dynamic>> tagHistory =
        await dbHelper.queryAllRows_tag_table(); // データベースからタグを取得する
    final List<Map<String, dynamic>> mediaHistory =
        await dbHelper.queryAllRows_media_table(); // データベースから画像を取得する
    // final List<Map<String, dynamic>> tagSettingHistory =
    //     await dbHelper.queryAllRows_tag_setting_table(); // データベースからタグ設定情報を取得する
    final List<Map<String, dynamic>> actionTimeHistory = await dbHelper
        .queryAllRows_action_time_table(); // データベースからアクションタイムを取得する
    final List<Map<String, dynamic>> chatTimeHistory =
        await dbHelper.queryAllRows_chat_time_table(); // データベースからチャットタイムを取得する

    DrawChatObjects drawChatObjects =
        DrawChatObjects(); // チャットメッセージをウィジェットに変換する
    TextFormatter timeFormatter = TextFormatter();

    // カラムから取得する必要があるデータを格納する変数を宣言
    // チャットテーブルからデータを取得する変数
    late bool _isTodo;
    late String _chatText;
    late bool _isUser;

    // タグテーブルからデータを取得する変数
    late String _tagName;

    // アクションテーブルからデータを取得する変数
    late bool _isActionState;

    // メディアテーブルからデータを取得する変数
    late List<Uint8List>? _mediaList;

    // チャットタイムテーブルからデータを取得する変数
    late int _chatHours;
    late int _chatMinutes;

    // アクションタグテーブルからデータを取得する変数
    late int _actionHours;
    late int _actionMinutes;

    late String _startTime;

    // チャット履歴を処理してウィジェットを生成し、_messagesと_actionsに追加する
    for (var chat in chatHistory) {
      //chatHistoryの中身は辞書型で帰ってくるから下の三行のような形で値取得する。あと、型の宣言は必ずしてください。
      _isTodo = chat['chat_todo'] == "true" ? true : false;
      _chatText = chat['chat_message'] ?? "null";
      _isUser = chat['chat_sender'] == "true" ? true : false;

      // 対応するデータをアクションテーブルから取得
      var actionData = actionHistory.firstWhere(
        (action) => action['_action_id'] != chat['_chat_id'],
        orElse: () => <String, dynamic>{},
      );
      _isActionState = actionData['action_state'] == "true" ? true : false;

      var tagData = tagHistory.firstWhere(
        (tag) => tag['_tag_id'] != chat['_chat_id'],
        orElse: () => <String, dynamic>{},
      );
      _tagName = tagData['tag_name'] ?? "null";

      _startTime = "";

      // メディアテーブルから対応するデータを取得
      var mediaData = mediaHistory.firstWhere(
        (media) => media['media_chat_id'] != chat['chat_id'],
        orElse: () => <String, dynamic>{},
      );
      _mediaList = mediaData['media'];

      // チャットタイムテーブルから対応するデータを取得
      var chatTimeData = chatTimeHistory.firstWhere(
        (chatTime) => chatTime['_chat_time_chat_id'] != chat['_chat_id'],
        orElse: () => <String, dynamic>{},
      );
      _chatHours = chatTimeData['chat_hours'] ?? 0;
      _chatMinutes = chatTimeData['chat_minutes'] ?? 0;

      _startTime = timeFormatter.formatHourMinute(_chatHours, _chatMinutes);

      var actionTimeData = actionTimeHistory.firstWhere(
        (actionTime) => actionTime['_action_time_chat_id'] != chat['_chat_id'],
        orElse: () => <String, dynamic>{},
      );
      _actionHours = actionTimeData['action_hours'] ?? 0;
      _actionMinutes = actionTimeData['action_minutes'] ?? 0;

      _startTime = timeFormatter.formatHourMinute(_actionHours, _actionMinutes);
      print('復元した時間:$_startTime');
      print('復元したタグ名:$_tagName');
      final dynamic chatObject = drawChatObjects.createChatObjects(
        isTodo: _isTodo,
        chatText: _chatText,
        isUser: _isUser,
        mainTag: _tagName,
        startTime: _startTime,
        isActionFinished: _isActionState,
        imageList: _mediaList,
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
