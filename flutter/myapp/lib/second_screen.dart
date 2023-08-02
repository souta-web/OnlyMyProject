import 'package:flutter/material.dart';
import 'timeline_date_retriever.dart';
import 'database_helper.dart';
import 'screen_transition.dart';

// デバッグ用の仮画面クラス
class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
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
                } else {
                  // 何らかの処理を実行
                }
              },
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }

  void _retrieveDataFromDatabase() async {
    TimeLineDataRetriever database = TimeLineDataRetriever();
    List<Map<String, dynamic>> actionData = await database.getActionData();

    // アクションデータの表示例
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
