import 'package:flutter/material.dart';

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
//childが6つ使われているけど、本来は１つのウィジェットに対してそこまで使うものではないので単純化してほしい
class ChatMessageReply extends StatelessWidget {
  final String reply;
  ChatMessageReply({required this.reply});

  @override
  Widget build(BuildContext context) {
    return Scaffold( //61～63にかけてscaffold,container,listview書いている部分は、return Containerのみでも問題ないかも(辻)
      body: Container(
        child: ListView( //child1つめ(辻)
          //画面全体の周りの余白
          padding: const EdgeInsets.all(20.0),
          children: [
            Expanded(
              child: Column(//child2つめ(辻)
                children: [
                  Padding(
                    //吹き出し下の余白
                    padding: EdgeInsets.only(bottom: 28.0),
                    child: Align(//child3つめ(辻)
                      //左側に寄せる
                      alignment: Alignment.centerLeft,
                      child: Container(//child4つめ(辻)
                        //角の丸みの設定
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color: Color.fromARGB(255, 189, 187, 184),
                        ),
                        child: Padding(//child5つめ(辻)
                          //文字と吹き出しの間の余白
                          padding: EdgeInsets.all(15.0),
                          child: Text(//child6つめ(辻)
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
