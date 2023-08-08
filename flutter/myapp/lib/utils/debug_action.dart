import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'register_action.dart';
import 'database_helper.dart';
import 'screen_transition.dart';

// アクションデータベースに登録する処理のデバッグ用クラス
class DebugAction extends StatefulWidget {
  @override
  _DebugActionState createState() => _DebugActionState();

  // チャット入力用テキストフィールドのコントローラ
  final TextEditingController _chatPageTextFieldController =
      TextEditingController();

  // アクションのON/OFFを制御するための値通知リスナー
  final ValueNotifier<bool> _toggleController = ValueNotifier<bool>(false);

  TextEditingController get chatPageTextFieldController =>
      _chatPageTextFieldController;
  ValueNotifier<bool> get toggleController => _toggleController;
}

class _DebugActionState extends State<DebugAction> {
  final RegisterAction registerAction = RegisterAction();

  final TextEditingController resultController = TextEditingController();

  List<Map<String, dynamic>> _chatData = []; // チャットデータを保持するリスト
  List<Map<String, dynamic>> _actionData = []; // アクションデータを保持するリスト
  String _errorMessage = ''; // エラーメッセージを保持

  // データベースからチャットデータとアクションデータを取得して表示するメソッド
  Future<void> displayData(BuildContext context) async {
    final Database? db = await DatabaseHelper.instance.database;

    try {
      // チャットテーブルのデータを取得
      final List<Map<String, dynamic>> chatData =
          await db!.query(DatabaseHelper.chat_table);

      // アクションテーブルのデータを取得
      final List<Map<String, dynamic>> actionData =
          await db.query(DatabaseHelper.action_table);

      print('チャットテーブルのデータ:');
      chatData.forEach((row) {
        print(row);
      });

      print('アクションテーブルのデータ:');
      actionData.forEach((row) {
        print(row);
      });

      setState(() {
        _chatData = chatData; // 取得したチャットデータを保持
        _actionData = actionData; // 取得したアクションデータを保持
        _errorMessage = ''; // エラーメッセージをクリア
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'データの取得中にエラーが発生しました'; // エラーメッセージを設定
        print('データの取得中にエラーが発生しました');
      });
    }
  }

  // データベースからチャットデータを取得して表示するメソッド
  Future<void> displayChatData(BuildContext context) async {
    final Database? db = await DatabaseHelper.instance.database;

    try {
      final List<Map<String, dynamic>> chatData =
          await db!.query(DatabaseHelper.chat_table);

      print('チャットテーブルのデータ:');
      chatData.forEach((row) {
        print(row);
      });

      setState(() {
        _chatData = chatData;
        _errorMessage = '';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'データの取得中にエラーが発生しました';
        print('データの取得中にエラーが発生しました');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Debug Action'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ユーザーが入力するテキストフィールド
            TextFormField(
              controller:
                  registerAction.debugAction.chatPageTextFieldController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            // アクションのON/OFFを切り替えるスイッチ
            ValueListenableBuilder<bool>(
              valueListenable: registerAction.debugAction.toggleController,
              builder: (context, isAction, child) {
                return Switch(
                  value: isAction,
                  onChanged: (newValue) {
                    setState(() {
                      registerAction.debugAction.toggleController.value =
                          newValue;
                    });
                  },
                );
              },
            ),
            // アクションを登録するボタン
            ElevatedButton(
              onPressed: () async {
                if (registerAction.debugAction.toggleController.value) {
                  await registerAction.sendAction();
                  resultController.text = 'アクションが登録されました。';
                } else {
                  await registerAction.sendChat();
                  resultController.text = 'チャットが登録されました。';
                }
              },
              child: Text("登録"),
            ),
            // データを表示するボタン
            ElevatedButton(
              onPressed: () async {
                await displayData(context); // データの表示メソッドを呼び出す
              },
              child: Text("データを表示"),
            ),
            // チャットデータを表示するボタン
            ElevatedButton(
              onPressed: () async {
                await displayChatData(context); // チャットデータの表示メソッドを呼び出す
              },
              child: Text("チャットデータを表示"),
            ),
            // アクション結果やエラーメッセージを表示するテキストフィールド
            TextFormField(
              controller: resultController,
              enabled: false,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            // エラーメッセージを表示
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            // チャットデータのリスト表示
            if (_chatData.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _chatData.length,
                  itemBuilder: (context, index) {
                    final row = _chatData[index];
                    return ListTile(
                      title: Text('チャットデータ: $row'),
                    );
                  },
                ),
              ),
            // アクションデータのリスト表示
            if (_actionData.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _actionData.length,
                  itemBuilder: (context, index) {
                    final row = _actionData[index];
                    return ListTile(
                      title: Text('アクションデータ: $row'),
                    );
                  },
                ),
              ),
            // 画面遷移を行うボタン
            Center(
              child: ElevatedButton(
                onPressed: () {
                  bool canGoBack =
                      ScreenTransition.canPop(context, '/'); // ここでは遷移元を'/'と仮定

                  if (canGoBack) {
                    Navigator.pop(context); // 遷移元の画面に戻る
                  }
                },
                child: Text('戻る'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
