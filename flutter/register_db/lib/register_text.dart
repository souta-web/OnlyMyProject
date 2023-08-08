import 'dart:io';
import 'package:flutter/material.dart';
import 'utils/database_helper.dart';

class RegisterText extends StatefulWidget {
  @override
  _RegisterTextState createState() => _RegisterTextState();
}

class _RegisterTextState extends State<RegisterText> {
  //テキストフィールドに入力されたテキストを取得する
  final TextEditingController _textController = TextEditingController();
  //データベースから取得した保存されたテキストを格納するためのリスト
  final List<String> _savedTexts = [];
  //このリストはアプリの起動時に _refreshSavedTexts() メソッドを呼び出してデータベースから読み込まれたテキストが保持されます

  @override
  void initState() {
    //関数は値を返さない
    super.initState();
    // アプリ起動時にデータベースから保存されたテキストを読み込む
    _refreshSavedTexts();
  }

  @override //確認用画面
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              // テキストフィールドのコントローラーを設定
              controller: _textController,
              // テキストフィールドの装飾
              decoration: InputDecoration(labelText: 'テキストを入力'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              // ボタンが押されたときの処理を設定
              onPressed: () =>
                  _saveText(_textController.text.trim(), 0), // 送信者情報を0として保存
              child: Text('保存'), // ボタンのテキスト
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _savedTexts.length, // リストの要素数
                itemBuilder: (context, index) {
                  return ListTile(
                    // リストの各要素に表示するテキスト
                    title: Text(_savedTexts[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // テキスト保存処理
  Future<void> _saveText(String text, int sender) async {
    // 入力されたテキストを取得し、前後の空白を削除
    final trimmedText = _textController.text.trim();

    if (trimmedText.isNotEmpty) {
      // チャットのテキストをデータベースに保存
      saveChatTextToDatabase(trimmedText, sender);
      // テキストフィールドをクリア
      _textController.clear();
      // 保存されたテキストを再読み込みして表示を更新
      _refreshSavedTexts();

      setState(() {
        //データ登録確認
        _textController.clear();
        // データが登録されましたメッセージを表示する
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('メッセ'),
              content: Text('データが登録されました'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      });
    }
  }

  // データベースにテキストを保存
  void saveChatTextToDatabase(String text, int sender) async {
    await DatabaseHelper.instance.insert_chat_table({
      DatabaseHelper.columnChatSender: sender, // 送信者情報0,1
      DatabaseHelper.columnChatTodo: 'false', // todoかどうか
      DatabaseHelper.columnChatTodofinish: 0, // todo完了状態
      DatabaseHelper.columnChatMessage: text, // チャットのテキスト
      DatabaseHelper.columnChatTime: DateTime.now().toIso8601String(), // 送信時間
      DatabaseHelper.columnChatChannel: 'general', // チャットチャンネル
    });
  }

  // 保存されたテキストをデータベースから読み込み
  Future<void> _refreshSavedTexts() async {
    // データベースからすべてのテキストを取得
    final savedTexts = await DatabaseHelper.instance.queryAllRows_chat_table();
    setState(() {
      // リストをクリア
      _savedTexts.clear();
      // 取得したテキストを表示用のリストに設定して画面を更新
      _savedTexts.addAll(savedTexts
          .map((row) => row[DatabaseHelper.columnChatMessage] as String));
    });
  }
}

/*
void main() {
  runApp(MaterialApp(
    home: RegisterText(),
  ));
}
*/