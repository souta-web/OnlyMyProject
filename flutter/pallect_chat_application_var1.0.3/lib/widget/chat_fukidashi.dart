import 'package:flutter/material.dart';

class ChatFukidashi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('fukidashi')),
    );
  }
}

//メッセージ送信吹き出し
class ChatMessageSend extends StatelessWidget {
  final String send;
  ChatMessageSend({required this.send});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          //画面全体の周りの余白
          padding: const EdgeInsets.all(20.0),
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    //吹き出し下の余白
                    padding: EdgeInsets.only(bottom: 18.0),
                    child: Align(
                      //右側に寄せる
                      alignment: Alignment.centerRight,
                      child: Container(
                        //角の丸みの設定
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: Color.fromARGB(255, 255, 149, 21),
                        ),
                        child: Padding(
                          //文字と吹き出しの間の余白
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            send,
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//メッセージ返信吹き出し
class ChatMessageReply extends StatelessWidget {
  final String reply;
  ChatMessageReply({required this.reply});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          //画面全体の周りの余白
          padding: const EdgeInsets.all(20.0),
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    //吹き出し下の余白
                    padding: EdgeInsets.only(bottom: 28.0),
                    child: Align(
                      //左側に寄せる
                      alignment: Alignment.centerLeft,
                      child: Container(
                        //角の丸みの設定
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color: Color.fromARGB(255, 189, 187, 184),
                        ),
                        child: Padding(
                          //文字と吹き出しの間の余白
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            reply,
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
