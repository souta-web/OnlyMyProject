import 'package:flutter/material.dart';

class ChatScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        automaticallyImplyLeading: false, // バックボタンを非表示にする
        actions: [  
          IconButton(
            icon: Icon(Icons.settings),
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
