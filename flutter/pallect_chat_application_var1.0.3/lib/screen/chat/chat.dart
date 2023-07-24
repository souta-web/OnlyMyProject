import 'package:flutter/material.dart';

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
          leading: const Icon(Icons.account_circle),
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
            new Container(
                color: Color.fromARGB(255, 103, 100, 100),
                child: Column(children: <Widget>[
                  new Form(
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
                            child: new TextFormField(
                          //controller: messageTextInputCtl,
                          keyboardType: TextInputType.multiline, //複数行のテキスト入力
                          maxLines: 5,
                          minLines: 1,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(255, 164, 160, 160),
                            hintText: 'メッセージを入力してください',
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
