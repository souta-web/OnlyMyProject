import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'register_action.dart';
import 'database_helper.dart';
import 'screen_transition.dart';

class DebugAction extends StatefulWidget {
  @override
  _DebugActionState createState() => _DebugActionState();

  final TextEditingController _chatPageTextFieldController =
      TextEditingController();

  final ValueNotifier<bool> _toggleController = ValueNotifier<bool>(false);

  TextEditingController get chatPageTextFieldController =>
      _chatPageTextFieldController;
  ValueNotifier<bool> get toggleController => _toggleController;

  // データベース内のデータを表示するメソッド
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
    } catch (e) {
      print('データ表示中にエラーが発生しました');
    }
  }
}

class _DebugActionState extends State<DebugAction> {
  final RegisterAction registerAction = RegisterAction();

  // アクションの結果を画面に表示するためのテキストコントローラ
  final TextEditingController resultController = TextEditingController();

  // デバッグ画面のウィジェットを作成
  Widget buildDebugScreen(BuildContext context) {
    return DebugAction(); // DebugActionを直接返す
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
            TextFormField(
              controller:
                  registerAction.debugAction._chatPageTextFieldController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            ValueListenableBuilder<bool>(
              valueListenable: registerAction.debugAction._toggleController,
              builder: (context, isAction, child) {
                return Switch(
                  value: isAction,
                  onChanged: (newValue) {
                    setState(() {
                      registerAction.debugAction._toggleController.value =
                          newValue;
                    });
                  },
                );
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (registerAction.debugAction._toggleController.value) {
                  await registerAction.sendAction();
                  resultController.text = 'アクションが登録されました。';
                } else {
                  resultController.text = 'トグルがオフのため、アクションは登録されませんでした。';
                }
              },
              child: Text("アクションを登録"),
            ),
            ElevatedButton(
              onPressed: () async {
                // データを表示するためのボタン
                await widget.displayData(context);
              },
              child: Text("データを表示"),
            ),
            TextFormField(
              controller: resultController,
              enabled: false,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  bool canGoBack =
                      ScreenTransition.canPop(context, '/'); // ここでは遷移元を'/'と仮定

                  if (canGoBack) {
                    Navigator.pop(context); // 遷移元の画面に戻る
                  }
                },
                child: Text('戻る'), // ScreenTransitionクラスを使用した遷移元に戻るボタン
              ),
            )
          ],
        ),
      ),
    );
  }
}
