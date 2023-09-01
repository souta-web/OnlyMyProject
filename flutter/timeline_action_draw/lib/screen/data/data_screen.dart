import 'package:flutter/material.dart';

class DataScreenWidget extends StatelessWidget {
  
  final List<dynamic> _actions = [];

  void initState() {
    _actions.add(actionWidget());
    _actions.add(actionWidget());
    _actions.add(actionWidget());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
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
      body: Column(
        children:[
          Expanded(
            child:ListView.builder(
              itemCount: _actions.length,
              itemBuilder: (BuildContext context, int index) {
                return _actions[index];
              },
            ),
          )
        ],
      ),
    );
  }


  Widget actionWidget() {
    return Container(
      width: 100,
      height: 300,
      color: Colors.red,
      margin: EdgeInsets.symmetric(vertical: 10), // ウィジェット間の余白を設定
    );
  }
}