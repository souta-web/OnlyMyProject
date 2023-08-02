import 'package:flutter/material.dart';
import 'timeline_date_retriever.dart';
import 'database_helper.dart';

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
        child: ElevatedButton(
          onPressed: () {
            _retrieveDataFromDatabase();
          },
          child: Text('Retrieve Data'),
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
