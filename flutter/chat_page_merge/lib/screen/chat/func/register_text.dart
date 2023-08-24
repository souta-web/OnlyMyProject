import 'package:flutter/material.dart';
import '/utils/database_helper.dart';
import '/widget/chat_fukidashi.dart';

// テキストをデータベースに登録する
class RegisterText {
  // テキストフィールドに入力されたテキストをデータベースに登録する
  static void _registerTextToDatabase(String text, int sender) async {
    // テキストがnullでないかをチェック
    if (text.isNotEmpty) {
      // DatabaseHelperのインスタンス生成
      final DatabaseHelper dbHelper = DatabaseHelper.instance;
      String time = DateTime.now().toIso8601String();
      // 登録するデータの行を生成
      Map<String, dynamic> row = {
        DatabaseHelper.columnChatSender: sender, // 送信者情報: 0 (0=User, 1=AI)
        DatabaseHelper.columnChatTodo:
            'false', // todoかどうか: false (false=message)
        DatabaseHelper.columnChatMessage: text, // チャットのテキスト
        DatabaseHelper.columnChatTime: time, // 送信時間
        DatabaseHelper.columnChatActionId: 0,
      };

      // データベースに行を追加する
      await dbHelper.insert_chat_table(row);
    }
  }

  // メッセージの送信を処理するメソッド
  static void handLeSubmitted(String text, List<dynamic> messages,
      TextEditingController controller) async {
    String replyText = "データが登録されました"; // 返信メッセージの内容
    print(replyText);

    // テキストをデータベースに登録して返答メッセージを表示する
    _registerAndShowReplyMessage(text, replyText, messages, controller);

    ChatMessage userMessage =
        ChatMessage(text: text, isSentByUser: true); // 応答側のメッセージ
    ChatMessage replyMessage =
        ChatMessage(text: replyText, isSentByUser: false); // 返信側のメッセージ

    // テキスト入力をクリアする
    controller.clear();

    // チャットメッセージをリストの先頭に追加する
    messages.add(userMessage);
    messages.add(replyMessage);
  }

  // テキストをデータベースに登録し、返答メッセージを表示するメソッド
  static _registerAndShowReplyMessage(String text, String replyText,
      List<dynamic> messages, TextEditingController controller) async {
    final dbHelper = DatabaseHelper.instance;
    final chats = await dbHelper.queryAllRows_chat_table();

    // テキストをデータベースに登録
    _registerTextToDatabase(text, 0); // 0は送信者を'ユーザー'とする
    _registerTextToDatabase(replyText, 1); // 1は返答者を'AI'とする

    if (controller.text.isNotEmpty) {
      // テキストフィールドに値が入っているかチェック
      // 新しいチャットメッセージを作成する
      ChatMessage userMessage =
          ChatMessage(text: text, isSentByUser: true); // 応答側のメッセージ
      ChatMessage replyMessage =
          ChatMessage(text: replyText, isSentByUser: false); // 返信側のメッセージ
      // チャットメッセージをリストの先頭に追加する
      messages.add(userMessage);
      messages.add(replyMessage);

      // テキストをクリアする
      controller.clear();

      // 新しいメッセージを読み込む
      await _loadChatMessages(messages);
      // メッセージ表示を更新
      messages.clear();
      messages.addAll(chats);
    }
  }

  // 新しいメッセージをデータベースから読み込む
  static Future<void> _loadChatMessages(List<dynamic> messages) async {
    // databasehelperのインスタンス生成
    final dbHelper = DatabaseHelper.instance;
    final chats = await dbHelper.queryAllRows_chat_table();

    messages.clear(); // メッセージをクリアする
    chats.forEach((chat) {
      messages.add(ChatMessage(
        text: chat[DatabaseHelper.columnChatMessage],
        isSentByUser: chat[DatabaseHelper.columnChatSender] == 0,
      ));
    });
  }

  // データ確認用メソッド
  static Future<void> confirmData() async {
    // データ確認や表示ロジックをここに記述
    final dbHelper = DatabaseHelper.instance;
    final List<Map<String, dynamic>> chats =
        await dbHelper.queryAllRows_chat_table();

    print("チャットテーブルのデータ:");
    chats.forEach((chat) {
      print(
          "ID: ${chat[DatabaseHelper.columnChatId]}, Sender: ${chat[DatabaseHelper.columnChatSender]}, Todo: ${chat[DatabaseHelper.columnChatTodo]}, Text: ${chat[DatabaseHelper.columnChatMessage]}, Time: ${chat[DatabaseHelper.columnChatTime]} ChatActionId: ${chat[DatabaseHelper.columnChatActionId]},");
    });
  }
}
