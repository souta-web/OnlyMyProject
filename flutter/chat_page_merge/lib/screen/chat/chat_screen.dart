import 'package:flutter/material.dart';
import '/widget/chat_fukidashi.dart';

class ChatScreenWidget extends StatelessWidget {
  // テキスト入力フィールドのコントローラー
  final TextEditingController _textEditingController = TextEditingController();
  // チャットメッセージのリスト
  final List<dynamic> _messages = [ChatMessage(text: "aaaa",isSentByUser: true),
                                   ChatMessage(text: "testdayo", isSentByUser: false),
                                   ChatMessage(text: "testdayo", isSentByUser: false),
                                   ChatMessage(text: "testdayo", isSentByUser: false),
                                   ChatMessage(text: "testdayo", isSentByUser: false),
                                   ChatMessage(text: "testdayo", isSentByUser: false),
                                   ChatMessage(text: "testdayo", isSentByUser: false),
                                   ChatMessage(text: "testdayo", isSentByUser: false),
                                   ChatMessage(text: "testdayo", isSentByUser: false),
                                   ChatMessage(text: "testdayo", isSentByUser: false),
                                   ChatMessage(text: "testdayo", isSentByUser: false),
                                   ChatMessage(text: "testdayo", isSentByUser: false),
                                   ChatMessage(text: "testdayo", isSentByUser: false),];
                                   //今はサンプルのデータを入れているけど実際には空の状態でプログラムを動作させます

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(//appbarを作成
        title: Text('Chat'),
        //左上のアイコン
        leading: IconButton(//左上のアカウントアイコン
          icon: CircleAvatar(
            backgroundImage: AssetImage('assets/images/account_icon.png'),
            backgroundColor: Colors.transparent, // 背景色
            radius: 25,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(//右上の三点リーダーのやつ
            icon: Icon(Icons.more_vert),
            onPressed: () {
              Navigator.pushNamed(context, '/config'); //routeに追加したconfigに遷移
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(//Expandedの中身が吹き出しを表示するためのプログラム。_messages配列の中身をListView形式でループして表示させている
            child: ListView.builder(
              itemCount: _messages.length,//表示させるアイテムのカウント
              itemBuilder: (context, index) {//画面に描画
                return _messages[index];
              },
            ),
          ),
          Container(
            color: Color.fromARGB(255, 103, 100, 100),
            child: Column(
              children: [
                Form(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.textsms),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                      IconButton( //メディア追加ボタン
                        icon: Icon(Icons.add),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 222, 216, 216),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: _textEditingController,
                            keyboardType: TextInputType.multiline, //複数行のテキスト入力
                            maxLines: 5,
                            minLines: 1,
                            cursorColor: Color.fromARGB(255, 75, 67, 93),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'メッセージを入力してください',
                              //hintTextの位置
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 11.0,
                              )
                            ), 
                          ),
                        )
                      ),
                      Material( //送信ボタンを作成
                        color: Color.fromARGB(255, 103, 100, 100),
                        child: Center(
                          child: Ink(
                            child: IconButton(
                              icon: Icon(Icons.send),
                              color: Colors.white,
                              onPressed: () {
                                //ここに送信ボタンが押された時の動作を記述する
                                //ここの中で関数を呼び出す
                              }, 
                            ),
                          ),
                        ),
                      )
                    ]
                  )
                ),
              ]
            )
          ),
        ],
      )
    );
  }
}
