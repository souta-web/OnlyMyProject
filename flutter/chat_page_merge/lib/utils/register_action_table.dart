import 'database_helper.dart';

class RegisterActionTable{
  final int? actionId;
  final String? actionName;
  final int? actionStart;
  final int? actionEnd;
  final int? actionDuration; //総時間
  final String? actionMessage;
  final String? actionMedia;
  final String? actionNotes; //説明文
  final int? actionScore;
  final int? actionState; //状態(0=未完了,1=完了)
  final String? actionPlace;
  final String? actionMainTag;
  final String? actionSubTag;

  RegisterActionTable ({this.actionId,
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
                    });

  void registerActionTableFunc() async {
    print("これからデータベース登録");
    final DatabaseHelper dbHelper = DatabaseHelper.instance;
    Map<String, dynamic> row = {
      DatabaseHelper.columnActionName : actionName,
      DatabaseHelper.columnActionStart : actionStart,
    };

    await dbHelper.insert_action_table(row);

    //↓デバッグ用のデータ表示プログラム
    final allRows = await dbHelper.queryAllRows_action_table();
    print('全てのデータを照会しました。');
    allRows.forEach(print);
  }
}