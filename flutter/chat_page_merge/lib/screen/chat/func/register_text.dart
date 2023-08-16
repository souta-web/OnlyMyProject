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
      // 登録するデータの行を生成
      Map<String, dynamic> row = {
        DatabaseHelper.columnChatSender: sender, // 送信者情報: 0 (0=User, 1=AI)
        DatabaseHelper.columnChatTodo:
            'false', // todoかどうか: false (false=message)
        DatabaseHelper.columnChatMessage: text, // チャットのテキスト
        DatabaseHelper.columnChatTime: DateTime.now().toIso8601String(), // 送信時間
        DatabaseHelper.columnChatActionId: 0,
      };

      // データベースに行を追加する
      await dbHelper.insert_chat_table(row);
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
          isSentByUser: chat[DatabaseHelper.columnChatSender] == 0));
    });
  }

  // テキストをデータベースに登録し、返答メッセージを表示するメソッド
  static registerAndShowReplyMessage(String text, List<dynamic> messages,
      TextEditingController controller) async {
    final dbHelper = DatabaseHelper.instance;
    final chats = await dbHelper.queryAllRows_chat_table();

    // テキストをデータベースに登録
    _registerTextToDatabase(text, 1); // 1は送信者を'ユーザー'とする

    if (controller.text.isNotEmpty) {
      // テキストフィールドに値が入っているかチェック
      // 新しいチャットメッセージを作成する
      ChatMessage replyMessage =
          ChatMessage(text: text, isSentByUser: false); // 送信側のメッセージ
      // チャットメッセージをリストの先頭に追加する
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
}
