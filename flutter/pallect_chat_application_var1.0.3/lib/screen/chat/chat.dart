import 'package:flutter/material.dart';
import '/widget/chat_fukidashi.dart';
import '/widget/chat_todo.dart';

class ChatScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        //左上のアイコン
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
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //動作確認ボタン
          ElevatedButton(
            child: Text('吹き出し確認'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatFukidashi()
                )
              );
            }
          ),
          ElevatedButton(
            child: Text('Todo確認'),
            onPressed: () { 
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatTodo()
                )
              );
            }
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
                      IconButton(
                        icon: Icon(Icons.add),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                      Row(
                        
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
                          child: TextFormField(
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
                      Material(
                        color: Color.fromARGB(255, 103, 100, 100),
                        child: Center(
                          child: Ink(
                            child: IconButton(
                              icon: Icon(Icons.send),
                              color: Colors.white,
                              onPressed: () {},
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
