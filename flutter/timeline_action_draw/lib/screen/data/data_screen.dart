import 'package:flutter/material.dart';

class DataScreenWidget extends StatefulWidget {
  @override
  _DataScreenWidgetState createState() => _DataScreenWidgetState();
}

class _DataScreenWidgetState extends State<DataScreenWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/config');
            },
          ),
        ],
      ),
      body:TimeLineBody()
    );
  }
}

class TimeLineBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // constraintsはbodyのサイズを表すBoxConstraintsです。
        final _bodyWidth = constraints.maxWidth; //bodyの横幅取得
        final _bodyHeight = constraints.maxHeight; //bodyの縦幅を取得
        return Center(
          child:SingleChildScrollView(
            child:TimeLineBase(bodyWidth: _bodyWidth,bodyHeight: _bodyHeight,)
          ) 
        );
      },
    );
  }
}

class TimeLineBase extends StatefulWidget {
  TimeLineBase({required this.bodyWidth,required this.bodyHeight});
  //bodyのサイズを受け取る
  final double bodyWidth;
  final double bodyHeight;
  @override
  _TimeLineBase createState() => _TimeLineBase();
}

class _TimeLineBase extends State<TimeLineBase> {
  final double _timeDrawSpace = 50;
  final double _oneHourHeight = 100;
  final double _timeTextHeight = 16;
  final double _horizontalLineThickness = 1.5;

  @override

  Widget build(BuildContext context) {
    return Row (
      children: [
        //時間表示範囲
        SizedBox(
          width: _timeDrawSpace,
          height: _oneHourHeight * 24 - (_horizontalLineThickness * 48),
          child:Container(
            color: Colors.red,
            child:Column(
              children: [
                for (var i = 1; i < 24; i++)
                  Column(
                    children: [
                      SizedBox(
                        width:_timeDrawSpace,
                        height:_oneHourHeight-_timeTextHeight-(_horizontalLineThickness*2),
                      ),
                      Text(
                        '$i:00',
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
              ],
            )
          )
        ),
        SizedBox(
          width: widget.bodyWidth - _timeDrawSpace,
          height: _oneHourHeight * 24 - (_horizontalLineThickness * 48),
          child:Container(
            color: Colors.blue,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 左揃えに設定
              children: [
                for (var i = 1; i <= 48; i++)
                  Column(
                    children: [
                      //childrenの中身のheightの値の合計が_oneHourHeightになる
                      SizedBox(
                        width: widget.bodyWidth - _timeDrawSpace,
                        height: (_oneHourHeight/2)-(_horizontalLineThickness),
                        child:Container(
                          color: Colors.green,
                        )
                      ),
                      _drawHorizontalLine(),
                    ],
                ),
              ],
            )
          )
        )
      ],
    );
  }
  Widget _drawHorizontalLine() {
    return Divider(
      color: Colors.black, // 線の色を指定 (省略可能)
      height: 0, // 線の高さを指定 (余白？)
      thickness: _horizontalLineThickness, // 線の太さを指定 (省略可能)
      indent: 0.0, // 線の開始位置からのオフセットを指定 (省略可能)
      endIndent: 0.0, // 線の終了位置からのオフセットを指定 (省略可能)
    );
  }
}

class ActionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Opacity(//
      opacity: 0.5,
      child:Container(
        color: Colors.blue,
        height: 100.0,
        width: 110.0,
        child:Opacity(
          opacity: 0.3,
          child: Align(//※1のalighnmentを使えるようにする
            alignment: Alignment.topRight, //※1
            child: Container(
              height: 100.0,
              width: 100.0,
              color: Colors.blue[50],
            ),
          ),
        )
      ),
    );
  }
}