import 'package:flutter/material.dart';
//import 'config.dart';//一時コメントアウト

class ChatScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [  
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              Navigator.pushNamed(context, '/config');//routeに追加したconfigに遷移
            },
          ),
        ],
      ),
      ///記述範囲
      body: Center(
        child: Text('Chat Screen'),
      ),
      ///記述範囲
    );
  }
}
