import 'package:flutter/material.dart';
import '/utils/database_helper.dart';
import '/widget/chat_fukidashi.dart';

// テキストをデータベースに登録する
class RegisterText {
  // テキストフィールドに入力されたテキストをデータベースに登録する
  static void registerTextToDatabase(String text, int sender) async {
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

  // メッセージの送信を処理するメソッド
  static void handLeSubmitted(
      String text, List<dynamic> messages, TextEditingController controller) {
    _registerAndShowReplyMessage(text, messages, controller);
    // テキスト入力をクリアする
    controller.clear();
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
          isSentByUser: chat[DatabaseHelper.columnChatSender]));
    });
  }

  // テキストをデータベースに登録し、返答メッセージを表示するメソッド
  static _registerAndShowReplyMessage(String text, List<dynamic> messages, TextEditingController controller) async {
        
    final dbHelper = DatabaseHelper.instance;
    final chats = await dbHelper.queryAllRows_chat_table();
    // テキストをデータベースに登録
    registerTextToDatabase(text, 0); // 1は送信者を'ユーザー'とする
    if (controller.text.isNotEmpty) {
      // テキストフィールドに値が入っているかチェック
      // 新しいチャットメッセージを作成する
      ChatMessage message =
          ChatMessage(text: text, isSentByUser: true); // 送信側のメッセージ
      // チャットメッセージをリストの先頭に追加する
      messages.insert(0, message);

      String replyText = "データが登録されました"; // 返信メッセージの内容
      print(replyText);
      ChatMessage replayMessage =
          ChatMessage(text: replyText, isSentByUser: false);
      messages.insert(0, replayMessage);

      // 新しいメッセージを読み込む
      _loadChatMessages(messages).then((_) {
        // メッセージ表示を更新
        // Note: Stateを持たないクラス内で setStateを呼ぶための、このパターンを使用する
        WidgetsBinding.instance.addPostFrameCallback((_) {
          messages.clear();
          messages.addAll(chats);
        });
      });

      // テキストをクリアする
      controller.clear();
    }
  }
}
