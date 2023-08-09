import 'package:flutter/material.dart';
import '/widget/chat_fukidashi.dart';
import '/widget/chat_todo.dart';

//class TalkMessageListPage extends StatefulWidget {
//const TalkMessageListPage({Key key, this.messageList}) : super(key: key);

//final List<ChatMessageModel> messageList;

//@override
//_TalkMessageListPageState createState() => _TalkMessageListPageState();
//}

class ChatScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chat'),
          leading: IconButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage('assets/images/account_icon.png'),
              backgroundColor: Colors.transparent, // 背景色
              radius: 25,
            ),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                Navigator.pushNamed(context, '/config'); //routeに追加したconfigに遷移
              },
            ),
            /*Padding(
            padding: EdgeInsets.all(10),
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                CircleAvatar(
                  radius: 20.0,
                  //child: ClipOval(),
                  backgroundColor: Colors.orange,
                ),
                Positioned(
                  //right: 0.0,
                  //left: 10.0,
                  //bottom: 5.0,
                  //top: 2.0,
                  //width: 37.0,
                  //height: 30.0,
                  child: RawMaterialButton(
                    onPressed: () {},
                    shape: CircleBorder(),
                  ),
                ),
              ],
            ),
          ),*/
          ],
        ),

        ///記述範囲
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            //動作確認ボタン
            ElevatedButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return ChatFukidashi();
              })),
              child: Text('吹き出し確認'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return ChatTodo();
              })),
              child: Text('Todo確認'),
            ),

            new Container(
                color: Color.fromARGB(255, 103, 100, 100),
                child: Column(children: <Widget>[
                  new Form(
                      //formField用Widget
                      //key: _formKey,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.textsms),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                        new Flexible(
                            child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 222, 216, 216),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: new TextFormField(
                            //controller: messageTextInputCtl,
                            keyboardType: TextInputType.multiline, //複数行のテキスト入力
                            maxLines: 5,
                            minLines: 1,
                            cursorColor: Color.fromARGB(255, 75, 67, 93),
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'メッセージを入力してください',
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 11.0,
                                )), //hintTextの位置
                          ),
                        )),
                        Material(
                          color: Color.fromARGB(255, 103, 100, 100),
                          child: Center(
                            child: Ink(
                              child: IconButton(
                                icon: Icon(Icons.send),
                                color: Colors.white,
                                onPressed: () {
                                  //_addMessage(messageTextInputCtl.text);
                                  //FocusScope.of(context).unfocus();
                                  //messageTextInputCtl.clear();
                                },
                              ),
                            ),
                          ),
                        )
                      ])),
                ])),
          ],
        ));

    ///記述範囲
  }
}
