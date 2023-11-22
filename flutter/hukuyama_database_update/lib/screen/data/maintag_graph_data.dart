import '/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class MaintagGraphData {
  final String? columnTagName;
  //final String? tagTotalMinutes;
  //final String? tagTotalTime;

  MaintagGraphData({
    this.columnTagName,
    //this.tagTotalMinutes,
    //this.tagTotalTime
  });

  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  

  Future<List<MaintagGraphData>>
  fetchDataFromDatabase() async{
    final List<Map<String, dynamic>>
    dataMapList = await dbHelper.queryAllRows_tag_table();

    final List<MaintagGraphData> 
      dataList = dataMapList.map((dataMap) {
        return MaintagGraphData(
          columnTagName: dataMap[DatabaseHelper.columnTagName],
        );
      }).toList();

    return dataList;
  }
}

final dbHelper = DatabaseHelper.instance;

void queryAllRows_tagName() async {
Database? db = await dbHelper.database;

List<Map> result1 = await db!.rawQuery
('SELECT * FROM (SELECT * FROM tag_table LEFT JOIN action_table ON tag_table._tag_id = action_table._action_id) AS A GROUP BY _tag_id HAVING _tag_id % 2 = 0');
print(result1);
}

//SELECT
//SELECT * FROM tag_table

//WHERE
//OR
//SELECT tag_name FROM tag_table WHERE tag_name = "ゲーム" OR tag_name = "睡眠"
//AND
//SELECT tag_name FROM tag_table WHERE tag_name = "ゲーム" AND tag_name = "睡眠"
//NOT
//SELECT tag_name FROM tag_table WHERE NOT tag_name = "料理"
//IS NULL
//SELECT tag_name FROM tag_table WHERE tag_name = "料理" IS NULL
//LIKE
//SELECT tag_name FROM tag_table WHERE tag_name LIKE "%睡眠%"
//SELECT tag_name FROM tag_table WHERE tag_name LIKE "睡_"

//ORDER BY
//SELECT _tag_id FROM tag_table ORDER BY _tag_id ASC/DESC

//JOIN
//SELECT _tag_id FROM tag_table LEFT JOIN action_table ON tag_table._tag_id = action_table._action_id

//AS
//SELECT tag_name AS "タグ名" FROM tag_table WHERE tag_name="睡眠"

//COUNT
//SELECT COUNT(_tag_id) FROM tag_table
//MAX/MIN
//SELECT MAX/MIN(_tag_id) FROM tag_table
//AVG
//SELECT AVG(_tag_id) FROM tag_table
//SUM
//SELECT SUM(_tag_id) FROM tag_table

//GROUP BY
//SELECT tag_name, SUM(tag_color) FROM tag_table WHERE tag_name = 1 OR tag_name = 2 GROUP BY tag_name

//HAVING
//SELECT _tag_id FROM tag_table GROUP BY _tag_id HAVING _tag_id % 2 = 0

//サブクエリ使用
//SELECT * FROM (SELECT * FROM tag_table LEFT JOIN action_table ON tag_table._tag_id = action_table._action_id) AS A GROUP BY _tag_id HAVING _tag_id % 2 = 0




//List<Map> result2 = await db!.rawQuery
// ('SELECT action_name FROM action_table WHERE _action_id < 5');
// print(result2);

// List<Map> result = [...result1, ...result2];
//   print(result);







// バックからフロントに渡すデータの型
// メインタグ別のデータList<Map<String,String>>
// [{TagName:メインタグ名,TagTotalMinutes:そのタグの総時間(分変換),
// TagTotalTime:そのタグの総時間(XX時間YY分)},・・・同じ型の辞書型がメインタグ数だけ入る]
// アクション別のデータList<Map<String,String>>
// [{ActionName:アクション名,ActionTotalMinutes:そのアクションの総時間(分変換),
// ActionTotalTime:そのアクションの総時間(XX時間YY分),ThisActionTag:このアクションのに紐づけられているメインタグ名}
// ・・・選択されている範囲内のアクション数分だけ入る]