import 'package:flutter/material.dart';

class DataScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
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
        child: Text('Data Screen'),
      ),
      ///記述範囲
    );
  }
}