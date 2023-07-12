import 'package:flutter/material.dart';


class TimelineScreenWidget extends StatelessWidget {
  //final Size screenSize;

  //const TimelineScreenWidget({required this.screenSize});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timeline'),
        automaticallyImplyLeading: false, // バックボタンを非表示にするautomaticallyImplyLeading: false, // バックボタンを非表示にする
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
      body: SingleChildScrollView(//widgetが画面をはみ出すとスクロール可能に
        //child: Center(
          child: Column(
            children: <Widget>[
              for (var i = 0; i < 25; i++)
                Row(
                  children: <Widget>[
                    //SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        '$i:00',
                        textAlign: TextAlign.right, // テキストを右揃えにする
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      color: Color.fromARGB(255, 104, 104, 104),
                      width: 300.0,
                      height: 2.0,
                    ),
                    SizedBox(height: 60.0), // 上部の余白を追加
                    SizedBox(width: 30.0),
                  ],
                ),
            ],
          ),
        //)
      ),
      ///記述範囲
    );
  }
}