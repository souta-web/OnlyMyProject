import 'package:flutter/material.dart';
import 'database_helper.dart';

// テキストをデータベースに登録する
class RegisterText extends StatefulWidget {
  @override
  _RegisterTextState createState() => _RegisterTextState();
}

// ウィジェットの状態を管理する
class _RegisterTextState extends State<RegisterText> {
  TextEditingController _textController =
      TextEditingController(); // テキストフィールドのコントロールに使用する

  // テキストフィールドに入力されたテキストをデータベースに登録する
  void _registerTextToDatabase() async {
    String text = _textController.text;
    if (text.isNotEmpty) {
      final DatabaseHelper dbHelper = DatabaseHelper.instance;
      Map<String, dynamic> row = {
        DatabaseHelper.columnChatSender: 0, // 送信者情報: 0 (0=AI, 1=User)
        DatabaseHelper.columnChatTodo: false, // todoかどうか: false (false=message)
        DatabaseHelper.columnChatMessage: text, // チャットのテキスト
        DatabaseHelper.columnChatTime: DateTime.now().toIso8601String(), // 送信時間
        DatabaseHelper.columnChatChannel: 'channel', // チャットチャンネル（適宜変更）
      };
      await dbHelper.insert_chat_table(row);
      setState(() {
        _textController.clear();
        // データが登録されましたのような返答メッセージを表示する
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('メッセージ'),
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

  // ウィジェットのビルドを行う
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Text'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'テキストを入力してください',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerTextToDatabase,
              child: Text('登録'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RegisterText(),
  ));
}
