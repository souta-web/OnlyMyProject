import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

// actionをデータベースに登録する
class RegisterAction {
  bool isAction = false; // トグルボタンの状態を保持する変数

  // トグルボタンの状態変化を処理する関数
  void onToggleChanged(bool value) {
    isAction = value;
  }

  // アクションとチャットをデータベースに登録する変数
  Future<void> registerAction(
    String chatMessage,
    String chatTime,
    String chatChannel,
    String actionName,
    String actionStart,
    String actionEnd,
    String actionDuration,
    String actionMessage,
    String actionMedia,
    String actionNotes,
    int actionScore,
    String actionPlace,
    String actionMainTag,
    String actionSubTag,
  ) async {
    // DatabaseHelperからDatabaseインスタンスを取得
    final Database? db = await DatabaseHelper.instance.database;

    // チャットテーブルの登録データを作成
    Map<String, dynamic> chatRow = {
      DatabaseHelper.columnChatSender: 0, // 送信者情報: 0 (0=AI, 1=User)
      DatabaseHelper.columnChatTodo: isAction ? 'true' : 'false', // アクションの場合はtrueにする
      DatabaseHelper.columnChatTodofinish: isAction ? 0 : 1,  // アクションの場合は0にする（未完了）1（完了）
      DatabaseHelper.columnChatMessage: chatMessage,
      DatabaseHelper.columnChatTime: chatTime,
      DatabaseHelper.columnChatChannel: chatChannel,
    };

    // チャットテーブルにデータを登録し、chatIdを取得
    int chatId = await db!.insert(DatabaseHelper.chat_table, chatRow);

    if (isAction) {
      // アクションのテーブルの登録データを作成
      Map<String, dynamic> actionRow = {
        DatabaseHelper.columnActionId: chatId, // チャットのchatIdをaction_id_chatとして使用
        DatabaseHelper.columnActionName: actionName,
        DatabaseHelper.columnActionStart: actionStart,
        DatabaseHelper.columnActionEnd: actionEnd,
        DatabaseHelper.columnActionDuration: actionDuration,
        DatabaseHelper.columnActionMessage: actionMessage,
        DatabaseHelper.columnActionMedia: actionMedia,
        DatabaseHelper.columnActionNotes: actionNotes,
        DatabaseHelper.columnActionScore: actionScore,
        DatabaseHelper.columnActionState: 0, // 仮定として0を未完了とする
        DatabaseHelper.columnActionPlace: actionPlace,
        DatabaseHelper.columnActionMainTag: actionMainTag,
        DatabaseHelper.columnActionSubTag: actionSubTag,
      };

      // アクションテーブルにデータを登録
      await db.insert(DatabaseHelper.action_table, actionRow);
    }
  }
}
