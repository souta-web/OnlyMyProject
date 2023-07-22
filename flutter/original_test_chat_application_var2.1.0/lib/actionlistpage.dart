import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'utils/database_helper.dart';
import 'actiondetailpage.dart';

class ActionListPage extends StatefulWidget {
  @override
  _ActionListPage createState() => _ActionListPage();
}

class _ActionListPage extends State<ActionListPage> {
  // DatabaseHelper クラスのインスタンス取得
  final dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>?>(
      future: _GetActionDataForDB(),  // 非同期処理を実行する関数を指定
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // データがまだ取得されていない場合の処理
          return CircularProgressIndicator();  // ローディングインジケータなどの表示
        } else if (snapshot.hasError) {
          // データの取得中にエラーが発生した場合の処理
          return Text('Error: ${snapshot.error}');
        } else {
          // データが正常に取得された場合の処理
          List<Map<String, dynamic>>? data = snapshot.data;
          print(data);
          return SafeArea(
            child: Column(
              children: [
                _SortMenuActionList(),
                Expanded(
                  child:ListView.builder(
                    itemCount: data?.length,
                    itemBuilder: (context, index) {
                      String title = data?[index]['action_name'];
                      int item2 = data?[index]['_action_id'];
                      int state = data?[index]['action_state'];
                      return GestureDetector(
                        onTap: () {
                          // クリック時の処理を実装
                          print('Item clicked: $title');
                          _MoveActionDetailPageProcess(item2,context);
                        },
                        child:Column(// 各アイテムのウィジェットを返す
                          children: [
                            SizedBox(height: 1),
                            _ListCard(title,data?.length,state),
                            SizedBox(height: 1),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          );
        }
      },
    );
  }

  Widget _ListCard(String _title,int? _index, int state) {//画面に表示するtodoたちのデザイン
  // itemを使用してウィジェットを作成し、それを返す
  bool _state = (state == 1);//0と1をfalseとtrueに変換
  print(_index.toString());
    return Container(
      height: 50,
      width: double.infinity,
      color: Colors.amber[600],
      child:Row(
        children: [
          _getIcon(_state),
          Text(
            _title.toString(),
            style: TextStyle(
              fontSize: 20, // フォントサイズを指定
            ),
          ), 
        ],
      )
    );
  }

  Icon _getIcon(bool condition) {
    return condition ? Icon(Icons.check) : Icon(Icons.close);
  }


  Future<List<Map<String, dynamic>>?> _GetActionDataForDB() async {//データベースから情報を取得する
    Database? db = await DatabaseHelper.instance.database;//データベース取得
    final List<Map<String, dynamic>>? action_table_name = await db?.query(
      'action_table',
      columns: ['_action_id','action_name','action_state'], // 取得したいカラムのリスト
    );
    return action_table_name;
  }

  //ページ移動するための関数。idを引数としてもらう
  void _MoveActionDetailPageProcess(int action_id,BuildContext context) async {
    Database? db = await DatabaseHelper.instance.database;//データベース取得
    final List<Map<String, dynamic>>? result = await db?.query(
      'action_table', // テーブル名
      where: '_action_id = ?', // 条件式
      whereArgs: [action_id], // 条件の値
    );
    Navigator.pushNamed(
      context,
      '/actionDetailPage',
      arguments:{'choice_record':result?[0]}//main.dartのonGenerateRouteに引数として渡す,型はMap<String, dynamic>
    );
  }

  Widget _SortMenuActionList() {
    String? selectedValue;
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        onChanged: (newValue) {
          setState(() {
            selectedValue = newValue;
          });
        },
        items: [
          DropdownMenuItem(
            value: 'Option 1',
            child: Text('Option 1'),
          ),
          DropdownMenuItem(
            value: 'Option 2',
            child: Text('Option 2'),
          ),
          DropdownMenuItem(
            value: 'Option 3',
            child: Text('Option 3'),
          ),
        ],
      ),
    );
  }
}