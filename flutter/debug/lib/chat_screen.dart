import 'package:flutter/material.dart';
import 'screen_transition.dart';

// チャット画面を構築するウィジェット
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // チャットメッセージを格納するリスト
  final List<ChatMessage> _messages = <ChatMessage>[];
  // テキスト入力を受け付けるコントローラー
  final TextEditingController _textController = TextEditingController();

  // メッセージの送信を処理するメソッド
  void _handleSubmitted(String text) {
    // テキスト入力をクリアする
    _textController.clear();
    // 新しいチャットメッセージを作成する
    ChatMessage message = ChatMessage(
      text: text,
      sender: 'Me',
    );
    // チャットメッセージをリストの先頭に追加する
    setState(() {
      _messages.insert(0, message);
    });
  }

  // テキスト入力欄を構築するメソッド
  Widget _buildTextComposer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          // フレキシブルなテキストフィールド
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration.collapsed(hintText: 'Send a message'),
            ),
          ),
          // 送信ボタン
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // アプリバーのタイトル
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: <Widget>[
          // チャットメッセージを表示するためのリストビュー
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          // 区切り線
          Divider(height: 1.0),
          // テキスト入力欄を表示するコンテナ
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
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
              child: Text('Go Back'),
            ),
          )
        ],
      ),
    );
  }
}

// チャットメッセージを構築するウィジェット
class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.text, required this.sender});

  final String text; // 表示するテキスト用の変数定義
  final String sender; // 送信者の名前の変数定義

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0), // Containerの外枠の幅の設定
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align children to the top子Widgetを上揃えに
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                right: 16.0), // Margin on the right side of the container
            child: CircleAvatar(
                child: Text(sender[
                    0])), // Display the first letter of the sender's name as an avatar in a circular shape
          ),
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align children to the left
            children: <Widget>[
              Text(sender,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1), // Display the sender's name using the subtitle1 style from the app's theme
              Container(
                margin: EdgeInsets.only(
                    top: 5.0), // Margin on the top of the container
                child: Text(text), // Display the text message
              ),
            ],
          ),
        ],
      ),
    );
  }
}
