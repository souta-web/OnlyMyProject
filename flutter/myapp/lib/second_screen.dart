import 'package:flutter/material.dart';
import 'timeline_date_retriever.dart';
import 'database_helper.dart';
import 'screen_transition.dart';

// デバッグ用の仮画面クラス及びアクションテーブルのデータ確認クラス
class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  // ウィジェットのビルドを行う
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // データの情報をコンソールで確認する
                _retrieveDataFromDatabase();
              },
              child: Text('Retrieve Data'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                bool canGoBack =
                    ScreenTransition.canPop(context, '/'); // ここでは遷移元を'/'と仮定

                if (canGoBack) {
                  Navigator.pop(context); // 遷移元の画面に戻る
                }
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  // データベースからアクションを取得し、コンソールに表示する
  void _retrieveDataFromDatabase() async {
    // TimeLineDataRetrieverクラスのインスタンス作成
    TimeLineDataRetriever database = TimeLineDataRetriever();
    // データベースからアクションデータを取得する
    List<Map<String, dynamic>> actionData = await database.getActionData();

    // 各レコードの情報をコンソールに表示する
    for (var record in actionData) {
      print('ActionName: ${record[DatabaseHelper.columnActionName]}');
      print('ActionNotes: ${record[DatabaseHelper.columnActionNotes]}');
      print('Main Tag: ${record[DatabaseHelper.columnActionMainTag]}');
      print('Sub Tag: ${record[DatabaseHelper.columnActionSubTag]}');
      print('Status: ${record[DatabaseHelper.columnActionState]}');
      print('ActionScore: ${record[DatabaseHelper.columnActionScore]}');
      print('------------------');
    }
  }
}
