import 'package:flutter/material.dart';
import 'time_line_action_widget.dart';
import '../func/action_registration_base.dart';

class TimeLineBase extends StatefulWidget {
  TimeLineBase({required this.bodyWidth,required this.bodyHeight,required this.newData,});
  //bodyのサイズを受け取る
  final double bodyWidth;
  final double bodyHeight;
  final List<Map<String, dynamic>> newData; // 新しいデータを保持する変数を追加
  @override
  _TimeLineBase createState() => _TimeLineBase();
}

class _TimeLineBase extends State<TimeLineBase> {
  final double _timeDrawSpace = 50; //時間を表示する欄の横幅
  final double _oneHourHeight = 60; //これを変えたら1時間当たりの縦幅が変わる
  final double _timeTextHeight = 16; //時間テキストの縦幅 変えるとおかしくなる
  final double _horizontalLineThickness = 1.5; //横線の縦幅
  final double _timeLineActionDrawAreaMargin = 30; //時間とアクション表示領域の余白＆表示領域左の余白
  late double _timeLineHeight = _oneHourHeight * 24 - (_horizontalLineThickness * 48); //タイムライン画面の合計縦幅
  late double _timeLineActionDrawAreaWidth = widget.bodyWidth - _timeDrawSpace - _timeLineActionDrawAreaMargin; //アクション表示領域の横幅
  //↓この配列に要素を追加したらその分だけ表示数を増やせる。(開始時刻が早い順に並んでいないとうまく動かないかも)
  List<Map<String, dynamic>> _actionsDatas = [
    /*{"startTime": "0:00","endTime": "1:45" ,"color": Colors.amber,"title": "ポケモンスリープする"},
                                              {"startTime": "1:00","endTime": "2:45" ,"color": Colors.red,"title": "ご飯食べる"},
                                              {"startTime": "2:00","endTime": "8:00" ,"color": Colors.blue,"title": "学校に行く"},
                                              {"startTime": "5:00","endTime": "9:00" ,"color": Colors.pink,"title": "寝る"},
                                              {"startTime": "5:00","endTime": "6:00" ,"color": Colors.purple,"title": "BGM聞く"},
                                              {"startTime": "15:00","endTime": "18:00" ,"color": Colors.purple,"title": "ブルアカやる"},
                                              {"startTime": "16:00","endTime": "18:00" ,"color": Colors.purple,"title": "勉強やる"},
                                              {"startTime": "17:00","endTime": "17:30" ,"color": Colors.white,"title": "test"},
                                              */];
                                              
  List<Widget> _actionWidgets = [];
  //占領されていないアクション表示のエリアを格納
  //例えば{"startTime":60,"endTime":1440}であれば1:00～24:00の間はどのアクションにも占領されていないことになる
  List<List<Map<String,int>>> _clearActionArea = [[{"startTime":0,"endTime":1440}]]; 

  List<Map<String, dynamic>> get actionsDatas => _actionsDatas; // ここに追加
  @override

  void initState() {
    super.initState();
    _actionsDatas = widget.newData;
    _actionWidgets.add(_drawHorizontalLinesConstructure()); //これは表示領域のベースになるから変更してはいけない
    for (int i = 0; i < _actionsDatas.length;i++){
      _actionWidgets.add(_returnTimeLineActionWidget(_actionsDatas[i],_clearActionArea));

      _clearActionArea = removeRangeFromClearActionArea(_clearActionArea, ConversionTimeToMinutes(_actionsDatas[i]["startTime"]), ConversionTimeToMinutes(_actionsDatas[i]["endTime"]));
    }
    print("_clearActionAreaの中身:" + _clearActionArea.toString());   
    print("actionDatas");
    print(_actionsDatas);
    print("newDatas");
    print(widget.newData);
  }

  Widget build(BuildContext context) {
    return Row (
      children: [
        //時間表示範囲
        SizedBox(
          width: _timeDrawSpace,
          height: _timeLineHeight,
          child:Container(
            color: Colors.white,
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
                        style: TextStyle(
                          color: Colors.black, // テキストの色を黒に変更
                          fontSize: (14/16) * _timeTextHeight,    // テキストのフォントサイズ
                        ),
                      ),
                    ],
                  ),
              ],
            )
          )
        ),
        //時間表示とタイムライン間の余白
        Container(
          color: Colors.white,
          width: _timeLineActionDrawAreaMargin/2,
          height: _timeLineHeight,
        ),
        Stack(
          children:_actionWidgets
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
  
  Widget _drawHorizontalLinesConstructure() {
    return SizedBox(
      width: _timeLineActionDrawAreaWidth,
      height: _timeLineHeight,
      child:Container(
        color: Colors.white,
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
                      color: Colors.white,
                    )
                  ),
                  _drawHorizontalLine(),
                ],
            ),
          ],
        )
      )
    );
  }

  //タイムラインアクションウィジェットを作成して返す
  Widget _returnTimeLineActionWidget(Map<String, dynamic> _actionData, List<List<Map<String,int>>> _clearActionArea) {
    String _startTime = _actionData["startTime"];
    String _endTime = _actionData["endTime"];
    Color _color = _actionData["color"];
    String _title = _actionData["title"];

    return ActionWidget(startTime: _startTime,
                        endTime: _endTime ,
                        timeLineHeight: _timeLineHeight,
                        bodyWidth: _timeLineActionDrawAreaWidth,
                        color: _color,
                        title: _title,
                        clearActionArea:_clearActionArea
                       );
  }

  //アクションがタイムライン上のどの位置に表示されるかを計算する。(厳密には違う)
  List<List<Map<String, int>>> removeRangeFromClearActionArea(
    List<List<Map<String, int>>> clearActionArea,
    int actionStartTime,
    int actionEndTime,
  ) {
    // 結果のリスト
    List<List<Map<String, int>>> updatedClearActionArea = [];
    
    //受け取った配列の-1が2つ以上の場合はアクションの表示領域が確定されない可能性があるから、そうならないように追加しておく
    if(clearActionArea[clearActionArea.length -1 ].length > 1){
      clearActionArea.add([{"startTime":0,"endTime":1440}]);
    }

    bool confirmActionPosition = false;
    for (var entry in clearActionArea) {//引数で受け取った配列をfor文で回すList<List<Map<String, int>>>
      List<Map<String, int>> entryList = []; 
      for (var map in entry) {
        int startClearTime = map["startTime"] ?? 0;
        int endClearTime = map["endTime"] ?? 0;

        // 削除範囲にかかる場合、適切に分割して追加
        //アクションの位置がすでに確定している場合はfalseとなり、elseの中身を実行するだけ
        if (!confirmActionPosition) {
          //↓アクションを表示するエリアがある場合true
          print("confirmActionPositionは正常");
          if (startClearTime < actionStartTime && endClearTime > actionEndTime) {
            entryList.add({"startTime": startClearTime, "endTime": actionStartTime - 1});
            entryList.add({"startTime": actionEndTime + 1, "endTime": endClearTime});
            confirmActionPosition = true;
          } else {
            // 削除対象外の範囲なのでそのまま追加
            entryList.add(map);
          }
        }else{
          entryList.add(map);
        }
      }
      if (entryList.isNotEmpty) {
        updatedClearActionArea.add(entryList);
      }
    }

  return updatedClearActionArea;
  }

  //アクションの合計時間を計算する
  int ConversionTimeToMinutes(String _time) {
    List<String> _TimeList = _time.split(":");
    int _Hour = int.parse(_TimeList[0]) * 60;
    int _Minutes = int.parse(_TimeList[1]) + _Hour;
    return _Minutes;
  }

  void upDateData(List<Map<String, dynamic>> newData) {
    setState(() {
      _actionsDatas = widget.newData;
    });
  }
}