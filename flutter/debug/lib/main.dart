import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'search_database.dart';
import 'second_screen.dart';
import 'chat_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchScreen(),
      onGenerateRoute: (settings) {
        // SecondScreenに移動するための初期設定
        if (settings.name == '/second') {
          return MaterialPageRoute(
            builder: (context) => SecondScreen(),
          );
        }
        // ChatScreenに移動するための初期設定
        if (settings.name == '/chat') {
          return MaterialPageRoute(
            builder: (context) => ChatScreen(),
          );
        }
        // ルート名が'/second'or'/chat'以外の場合はホーム画面に遷移
        return MaterialPageRoute(
          builder: (context) => SearchScreen(),
          settings: settings,
        );
      },
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  String _searchMessage = '';

  final dbHelper = DatabaseHelper.instance;

  List<String> _getMatchedKeywords(String keyword) {
    List<String> matchedKeywords = [];

    // チャットテーブルを検索
    List<String> chatKeywords = _searchResults
        .where((record) => record.toString().toLowerCase().contains(keyword))
        .map((record) => 'チャットテーブル：${record[DatabaseHelper.columnChatId]}')
        .toList();
    matchedKeywords.addAll(chatKeywords);

    // アクションテーブルを検索
    List<String> actionKeywords = _searchResults
        .where((record) => record.toString().toLowerCase().contains(keyword))
        .map((record) => 'アクションテーブル：${record[DatabaseHelper.columnActionId]}')
        .toList();
    matchedKeywords.addAll(actionKeywords);

    // タグテーブルを検索
    List<String> tagKeywords = _searchResults
        .where((record) => record.toString().toLowerCase().contains(keyword))
        .map((record) => 'タグテーブル：${record[DatabaseHelper.columnTagId]}')
        .toList();
    matchedKeywords.addAll(tagKeywords);

    return matchedKeywords;
  }

  // 一致するキーワードの検索
  List<Widget> _buildMatchedKeywords() {
    List<String> matchedKeywords = _getMatchedKeywords(_searchController.text);

    if (matchedKeywords.isNotEmpty) {
      return [
        Text('一致するキーワード：'),
        ...matchedKeywords.map((keyword) => Text(keyword)),
      ];
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('データベース検索'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: '検索キーワードを入力してください',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // 検索ボタンがクリックされたとき、検索を実行
                String keyword = _searchController.text;
                List<Map<String, dynamic>> results =
                    await SearchDatabase().search(keyword);
                setState(() {
                  _searchResults = results;
                  _searchMessage =
                      _searchResults.isEmpty ? '一致する検索ワードがありません' : '';
                });
              },
              child: Text('検索'),
            ),
            SizedBox(height: 16.0),
            Text(_searchMessage),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('検索結果 ${index + 1}'),
                    subtitle: Text(_searchResults[index].toString()),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0), // ボタン間のスペース
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              child: Text('Second Screen へ遷移'),
            ),
            SizedBox(height: 16.0), // ボタン間のスペース
            ElevatedButton(
              onPressed: () {
                // ChatScreenに画面遷移
                Navigator.pushNamed(context, '/chat');
              },
              child: Text('Chat Screen へ遷移'),
            ),
            // SizedBox(height: 16.0),
            // // 一致するキーワードがあれば画面に表示
            // if (_searchResults.isNotEmpty) ..._buildMatchedKeywords(),

            //   // CRUD操作のためのボタン
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center, // 修正：ボタンを中央に配置
            //     children: <Widget>[
            //       ElevatedButton(
            //         child: Text(
            //           '登録',
            //           style: TextStyle(fontSize: 35),
            //         ),
            //         onPressed: _insert,
            //       ),
            //       ElevatedButton(
            //         child: Text(
            //           '照会',
            //           style: TextStyle(fontSize: 35),
            //         ),
            //         onPressed: _query,
            //       ),
            //       ElevatedButton(
            //         child: Text(
            //           '更新',
            //           style: TextStyle(fontSize: 35),
            //         ),
            //         onPressed: _update,
            //       ),
            //       ElevatedButton(
            //         child: Text(
            //           '削除',
            //           style: TextStyle(fontSize: 35),
            //         ),
            //         onPressed: _delete,
            //       ),
            //     ],
            //   ),
          ],
        ),
      ),
    );
  }

  // // 登録ボタンクリック
  // void _insert() async {
  //   // row to insert
  //   Map<String, dynamic> row = {
  //     // チャットテーブルデバッグ用
  //     DatabaseHelper.columnChatSender: '山田　ji郎',
  //     DatabaseHelper.columnChatTodo: 'true',
  //     DatabaseHelper.columnChatTodofinish: 'true',
  //     DatabaseHelper.columnChatMessage: 'Test Message',
  //     DatabaseHelper.columnChatTime: '10:10',
  //     DatabaseHelper.columnChatChannel: '1'
  //   };
  //   final id = await dbHelper.insert_chat_table(row);
  //   print('登録しました。id: $id');
  // }

  // // 照会ボタンクリック
  // void _query() async {
  //   final allRows = await dbHelper.queryAllRows_chat_table();
  //   print('全てのデータを照会しました。');
  //   allRows.forEach(print);
  // }

  // // 更新ボタンクリック
  // void _update() async {
  //   Map<String, dynamic> row = {
  //     DatabaseHelper.columnChatId: 1,
  //     DatabaseHelper.columnChatSender: '山田　鼻子',
  //     DatabaseHelper.columnChatTodo: 'false',
  //     DatabaseHelper.columnChatTodofinish: 'false',
  //     DatabaseHelper.columnChatMessage: 'Test Message2',
  //     DatabaseHelper.columnChatTime: '10:15',
  //     DatabaseHelper.columnChatChannel: '2'
  //   };
  //   final rowsAffected = await dbHelper.update_chat_table(row, 1);
  //   print('更新しました。 ID：$rowsAffected ');
  // }

  // // 削除ボタンクリック
  // void _delete() async {
  //   final id = await dbHelper.queryRowCount_chat_table();
  //   final rowsDeleted = await dbHelper.delete_chat_table(id!);
  //   print('削除しました。 $rowsDeleted ID: $id');
  // }

  // 登録ボタンクリック
  // void _insert() async {
  //   // row to insert
  //   Map<String, dynamic> row = {
  //     // アクションテーブルデバッグ用
  //     DatabaseHelper.columnActionName: 'ゲーム',
  //     DatabaseHelper.columnActionStart: '8:00',
  //     DatabaseHelper.columnActionEnd: '9:00',
  //     DatabaseHelper.columnActionDuration: '1:00',
  //     DatabaseHelper.columnActionMessage: 'アクションを開始しました',
  //     DatabaseHelper.columnActionMedia: 'メディアです',
  //     DatabaseHelper.columnActionNotes: 'ゲームをしています',
  //     DatabaseHelper.columnActionScore: '5',
  //     DatabaseHelper.columnActionState: '0',
  //     DatabaseHelper.columnActionPlace: '自宅',
  //     DatabaseHelper.columnActionMainTag: '#遊び',
  //     DatabaseHelper.columnActionSubTag: '#趣味'
  //   };
  //   final id = await dbHelper.insert_action_table(row);
  //   print('登録しました。id: $id');
  // }

  // // 照会ボタンクリック
  // void _query() async {
  //   final allRows = await dbHelper.queryAllRows_action_table();
  //   print('全てのデータを照会しました。');
  //   allRows.forEach(print);
  // }

  // // 更新ボタンクリック
  // void _update() async {
  //
  //   Map<String, dynamic> row = {
  //     DatabaseHelper.columnActionId: 1,
  //     DatabaseHelper.columnActionName: 'マラソン',
  //     DatabaseHelper.columnActionStart: '10:00',
  //     DatabaseHelper.columnActionEnd: '12:00',
  //     DatabaseHelper.columnActionDuration: '2:00',
  //     DatabaseHelper.columnActionMessage: 'アクションを開始しました',
  //     DatabaseHelper.columnActionMedia: 'マラソンメディアです',
  //     DatabaseHelper.columnActionNotes: '走っています',
  //     DatabaseHelper.columnActionScore: '10',
  //     DatabaseHelper.columnActionState: '1',
  //     DatabaseHelper.columnActionPlace: '公園',
  //     DatabaseHelper.columnActionMainTag: '#運動',
  //     DatabaseHelper.columnActionSubTag: '#トレーニング'
  //   };
  //   final rowsAffected = await dbHelper.update_action_table(row, 1);
  //   print('更新しました。 ID：$rowsAffected ');
  // }

  // // 削除ボタンクリック
  // void _delete() async {
  //   final id = await dbHelper.queryRowCount_action_table();
  //   final rowsDeleted = await dbHelper.delete_action_table(id!);
  //   print('削除しました。 $rowsDeleted ID: $id');
  // }

  // バグってるやつ
  // void _insert() async {
  //   // row to insert
  //   Map<String, dynamic> row = {
  //     // タグテーブルデバッグ用
  //     DatabaseHelper.columnTagName: 'ゲーム',
  //     DatabaseHelper.columnTagColor: '青',
  //     DatabaseHelper.columnTagRegisteredActionName: 'サマポケを攻略'
  //   };
  //   final id = await dbHelper.insert_tag_table(row);
  //   print('登録しました。ID: $id');
  // }

  // // 照会ボタンクリック
  // void _query() async {
  //   final allRows = await dbHelper.queryAllRows_tag_table();
  //   print('全てのデータを照会しました。');
  //   allRows.forEach(print);
  // }

  // // 更新ボタンクリック
  // void _update() async {
  //   Map<String, dynamic> row = {
  //     DatabaseHelper.columnTagId: 1,
  //     DatabaseHelper.columnTagName: '運動',
  //     DatabaseHelper.columnTagColor: '赤',
  //     DatabaseHelper.columnTagRegisteredActionName: '縄跳びをした'
  //   };
  //   final rowsAffected = await dbHelper.update_tag_table(row, 1);
  //   print('更新しました。 ID：$rowsAffected ');
  // }

  // // 削除ボタンクリック
  // void _delete() async {
  //   final id = await dbHelper.queryRowCount_tag_table();
  //   final rowsDeleted = await dbHelper.delete_tag_table(id!);
  //   print('削除しました。 $rowsDeleted ID: $id');
  // }
}
