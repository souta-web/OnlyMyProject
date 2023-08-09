import 'package:flutter/material.dart';
import 'timeline_data_retriever.dart';
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
        title: Text('Second Screen'), // アプリバーのタイトル
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // データの情報を取得してリストにセットし、ダイアログで表示
                actionData = await _retrieveDataFromDatabase();
                setState(() {});
                _showDataDialog(actionData);
              },
              child: Text('データ確認'), // データ確認ボタン
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                bool canGoBack = ScreenTransition.canPop(context, '/');
                if (canGoBack) {
                  Navigator.pushNamed(context,'/'); // 遷移元の画面に戻る
                }
              },
              child: Text('戻る'), // 戻るボタン
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> actionData = []; // 取得したアクションデータを保持するリスト

  Future<List<Map<String, dynamic>>> _retrieveDataFromDatabase() async {
    TimeLineDataRetriever database = TimeLineDataRetriever();
    return await database.getActionData(); // データベースからアクションデータを取得する
  }

  void _showDataDialog(List<Map<String, dynamic>> data) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('アクションデータ'), // ダイアログのタイトル
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: data.map((record) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ActionName: ${record[DatabaseHelper.columnActionName]}'), // アクション名
                    Text('ActionNotes: ${record[DatabaseHelper.columnActionNotes]}'), // アクションのノート
                    Text('Main Tag: ${record[DatabaseHelper.columnActionMainTag]}'), // メインタグ
                    Text('Sub Tag: ${record[DatabaseHelper.columnActionSubTag]}'), // サブタグ
                    Text('Status: ${record[DatabaseHelper.columnActionState]}'), // ステータス
                    Text('ActionScore: ${record[DatabaseHelper.columnActionScore]}'), // アクションスコア
                    Divider(), // 区切り線
                  ],
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ダイアログを閉じる
              },
              child: Text('閉じる'), // 閉じるボタン
            ),
          ],
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'timeline_data_retriever.dart';
// import 'database_helper.dart';
// import 'screen_transition.dart';

// // デバッグ用の仮画面クラス及びアクションテーブルのデータ確認クラス
// class SecondScreen extends StatefulWidget {
//   @override
//   _SecondScreenState createState() => _SecondScreenState();
// }

// class _SecondScreenState extends State<SecondScreen> {
//   // ウィジェットのビルドを行う
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Second Screen'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 // データの情報をコンソールで確認する
//                 _retrieveDataFromDatabase();
//               },
//               child: Text('データ確認'),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 bool canGoBack =
//                     ScreenTransition.canPop(context, '/'); // ここでは遷移元を'/'と仮定

//                 if (canGoBack) {
//                   Navigator.pushNamed(context, '/'); // 遷移元の画面に戻る
//                 }
//               },
//               child: Text('戻る'), // ScreenTransitionクラスを使用した遷移元に戻るボタン
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // データベースからアクションを取得し、コンソールに表示する
//   void _retrieveDataFromDatabase() async {
//     // TimeLineDataRetrieverクラスのインスタンス作成
//     TimeLineDataRetriever database = TimeLineDataRetriever();

//     // データベースからアクションデータを取得する
//     // これによりTimeLineDataクラス内のgetActionDataメソッド
//     // を使用してアクションデータの取得をする
//     // TimeLineDataRetriever クラスの 
//     // await database.getActionData()はgetActionData()メソッドを非同期で呼び出し、
//     // データベースからアクションデータを取得する
//     List<Map<String, dynamic>> actionData = await database.getActionData(); 
    

//     // 各レコードの情報をコンソールに表示する
//     // 取得したアクションデータをループ処理で表示
//     for (var record in actionData) {
//       print('ActionName: ${record[DatabaseHelper.columnActionName]}');
//       print('ActionNotes: ${record[DatabaseHelper.columnActionNotes]}');
//       print('Main Tag: ${record[DatabaseHelper.columnActionMainTag]}');
//       print('Sub Tag: ${record[DatabaseHelper.columnActionSubTag]}');
//       print('Status: ${record[DatabaseHelper.columnActionState]}');
//       print('ActionScore: ${record[DatabaseHelper.columnActionScore]}');
//       print('------------------');
//     }
//   }
// }
