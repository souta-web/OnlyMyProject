import 'database_helper.dart';

// アクション登録汎用クラス
class RegisterActionTable {
  final int? actionId;
  final String? actionTitle;
  final String? actionState;
  final String? actionNotes;
  final int? actionScore;

  RegisterActionTable({
    this.actionId,
    this.actionTitle,
    this.actionState,
    this.actionNotes,
    this.actionScore,
  });

  void registerActionTableFunc() async {
    // データベースに登録
    print("これからアクションテーブルに登録");
    final DatabaseHelper dbHelper = DatabaseHelper.instance;

    final Map<String, dynamic> actionRow = {
      DatabaseHelper.columnActionId: actionId, // アクションID
      DatabaseHelper.columnActionTitle: actionTitle,  // アクションタイトル
      DatabaseHelper.columnActionState: actionState, // 進行状態
      DatabaseHelper.columnActionNotes: actionNotes, // 説明文
      DatabaseHelper.columnActionScore: actionScore, // 充実度(1から5までの値で制限する)
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
