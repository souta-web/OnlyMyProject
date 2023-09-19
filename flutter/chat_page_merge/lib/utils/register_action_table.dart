import 'database_helper.dart';
import 'dart:typed_data';

// アクション登録汎用クラス
class RegisterActionTable {
  final int? actionId;
  final String? actionName;
  final String? actionStart;
  final String? actionEnd;
  final String? actionDuration;
  final String? actionMessage;
  final Uint8List? actionMedia;
  final String? actionNotes;
  final int? actionScore;
  final String? actionState;
  final String? actionPlace;
  final String? actionMainTag;
  final String? actionSubTag;
  final String? actionChatId;

  RegisterActionTable({
    this.actionId,
    this.actionName,
    this.actionStart,
    this.actionEnd,
    this.actionDuration,
    this.actionMessage,
    this.actionMedia,
    this.actionNotes,
    this.actionScore,
    this.actionState,
    this.actionPlace,
    this.actionMainTag,
    this.actionSubTag,
    this.actionChatId,
  });

  void registerActionTableFunc() async {
    // データベースに登録
    print("これからデータベースに登録");
    final DatabaseHelper dbHelper = DatabaseHelper.instance;
    final Map<String, dynamic> actionRow = {
      DatabaseHelper.columnActionId: actionId,  // アクションID
      DatabaseHelper.columnActionName: actionName, // アクション名
      DatabaseHelper.columnActionStart: actionStart, // 開始時刻
      DatabaseHelper.columnActionEnd: actionEnd, // 終了時刻
      DatabaseHelper.columnActionDuration: actionDuration, // 総時間
      DatabaseHelper.columnActionMessage: actionMessage, // 開始メッセージ
      DatabaseHelper.columnActionMedia: actionMedia, // 添付メディア
      DatabaseHelper.columnActionNotes: actionNotes, // 説明文
      DatabaseHelper.columnActionScore: actionScore, // 充実度(1から5までの値で制限する)
      DatabaseHelper.columnActionState: actionState, // 状態
      DatabaseHelper.columnActionPlace: actionPlace, // 場所
      DatabaseHelper.columnActionMainTag: actionMainTag, // メインタグ
      DatabaseHelper.columnActionSubTag: actionSubTag, // サブタグ
      DatabaseHelper.columnActionChatId: actionChatId, // チャットテーブルとアクションテーブル紐づけ用
    };

    await dbHelper.insert_action_table(actionRow);

    // デバッグ用データ表示プログラム
    final List<Map<String, dynamic>> allRows = await dbHelper.queryAllRows_action_table();
    print('全てのデータを照会しました。');
    allRows.forEach(print);
  }

  /*
  次のような形で呼び出すことができる
    RegisterActionTable registerActionTable = RegisterActionTable( //インスタンス化、引数渡し
      actionName: 'ゲーム',
      actionStart: '10:00',
    );

    registerActionTable.registerActionTableFunc(); //実際にデータベース登録
  */
}
