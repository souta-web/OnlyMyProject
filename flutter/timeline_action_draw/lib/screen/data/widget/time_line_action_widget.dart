import 'package:flutter/material.dart';

//アクション表示のクラス
class ActionWidget extends StatefulWidget {
  final double timeLineHeight; //タイムライン画面の縦幅
  final double bodyWidth; //横幅
  final String startTime; //アクションの開始時間
  final String endTime; //アクションの終了時間
  final Color color; //色
  final double leftVerticalLineLength = 10; //左の太い線の幅
  final String title; //アクション名
  final List<List<Map<String,int>>> clearActionArea; //アクションが表示されていない時間のリスト

  ActionWidget({required this.startTime,
                required this.endTime,
                required this.timeLineHeight,
                required this.bodyWidth,
                required this.color,
                required this.title,
                required this.clearActionArea
                });

  @override
  _ActionWidget createState() => _ActionWidget();
}

class _ActionWidget extends State<ActionWidget> {
  late double halfAnHourHeight = widget.timeLineHeight / 48; //タイムライン画面の合計の高さを48等分した高さをタイトルテキストの高さとする
  final double titleFontSize = 16;
  final double tagFontSize = 14;
  final double tagMargin = 5.0;
  final double tagPadding = 5.0;
  final double tagBorderRadius = 20;
  late double titleHeight = halfAnHourHeight;
  late double tagHeight = halfAnHourHeight - 5;
  late int actionTotalTime = calcTotalTime(widget.startTime,widget.endTime);
  late double widgetHeight = calcHeight(widget.startTime,widget.endTime);
  late double widgetLeft = calcLeft(widget.clearActionArea,widget.startTime,widget.endTime,widget.bodyWidth);

  @override

  Widget build(BuildContext context) {
    return Positioned(//アクションのタイムラインの表示領域上のどの位置に表示するかを決める(緑の領域)
      left: widgetLeft, // 左からのオフセット
      top: calcTop(widget.startTime), // 上からのオフセット
      child:Opacity(//ウィジェットの透明度
        opacity: 1,
        child: Row( //左の縦線とその右のメイン部分を並べて表示
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(//縦線
              color: widget.color,
              height: widgetHeight,
              width: widget.leftVerticalLineLength,
            ),
            Stack(
              children: [
                Opacity(//タイムラインアクションウィジェットの背景を作成
                  opacity: 0.3,
                  child: Align(//※1のalighnmentを使えるようにする
                    alignment: Alignment.topRight, //※1
                    child: Container(
                      height: widgetHeight,
                      width: widget.bodyWidth - widget.leftVerticalLineLength,
                      color: widget.color,
                    ),
                  ),
                ),
                drawTimeLineActionContents(actionTotalTime),//表示するコンテンツが返ってくる(タイトル、タグ)
              ],
            )
          ],
        )
      )
    );
  }

  //ウィジェットの縦幅に応じてタイトルとタグの適切な配置を返す
  //アクションの時間が60分未満の場合はタイトルとタグを横に並べる
  Widget drawTimeLineActionContents(int _totalTime) {
    if (_totalTime < 60){
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start, // 子ウィジェットを左揃えに設定
        children: [
          timeLineActionWidgetPartsTitle(),
          timeLineActionWidgetPartsTag(),
        ],
      );
    }else{
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 子ウィジェットを左揃えに設定
        children: [
          timeLineActionWidgetPartsTitle(),
          timeLineActionWidgetPartsTag(),
        ],
      );
    }
  }

  //タイムラインアクションウィジェットに表示するタイトルテキストを作成する
  Widget timeLineActionWidgetPartsTitle() {
    return Container(
      height: titleHeight,
      child:Text(//タイトルテキスト表示
        widget.title,
        style: TextStyle(
          color: Colors.black, // テキストの色を赤に変更
          fontSize: titleFontSize,    // テキストのフォントサイズ
          fontWeight: FontWeight.bold, // テキストのフォントの太さ
        ),
      ),
    );
  }

  //タイムラインアクションウィジェットに表示するタグを作成する
  Widget timeLineActionWidgetPartsTag() {
    return Container(
      height: tagHeight,
      margin: EdgeInsets.only(
        left: tagMargin,
        right: tagMargin,
      ),
      padding: EdgeInsets.only(
        left:tagPadding,
        right:tagPadding
      ), // テキストとコンテナの間にスペースを設定
      decoration: BoxDecoration(
        color: widget.color, // テキストの背景色を設定
        borderRadius: BorderRadius.circular(tagBorderRadius),
      ),
      child: Align(
        alignment: Alignment.center, // テキストを中央に配置
        child: Text(
          '#タグ',
          style: TextStyle(
            color: Colors.black, // テキストの色を設定
            fontSize: tagFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
    );
  }


  //タスクの開始時刻を[XX:YY]の形で受け取る
  //タスクの開始時刻から表示位置を計算する
  double calcTop(String startTime) {
    final int _oneDayMinutes = 1440;
    List<String> startTimeList = startTime.split(":");
    int startHour = int.parse(startTimeList[0]) * 60;
    int startMinutes = int.parse(startTimeList[1]) + startHour;

    double widgetTop = (widget.timeLineHeight/_oneDayMinutes) * startMinutes;

    return widgetTop;
  }

  //タイムラインアクションウィジェットの縦幅を計算する
  //アクションの合計時間から、表示時の縦幅を計算する
  double calcHeight(String startTime,String EndTime){
    final int _oneDayMinutes = 1440;
    List<String> startTimeList = startTime.split(":");
    List<String> endTimeList = widget.endTime.split(":");
    int startTimeConvMinutes = (int.parse(startTimeList[0]) * 60) + int.parse(startTimeList[1]);
    int endTimeConvMinutes = (int.parse(endTimeList[0]) * 60) + int.parse(endTimeList[1]);
    int totalTime = endTimeConvMinutes - startTimeConvMinutes;
    
    if (totalTime < 30) {
      totalTime = 30;
    }
  
    double widgetHeight = (widget.timeLineHeight/_oneDayMinutes) * totalTime;

    return widgetHeight;
  }

  //アクションの表示状態から、アクションのLeftの位置を計算する
  double calcLeft(List<List<Map<String,int>>> clearArea,_startTime,_endTime,_timeLineWidth) {
    List<String> startTimeList = _startTime.split(":");
    int startHour = int.parse(startTimeList[0]) * 60;
    int startTimeMinutes = int.parse(startTimeList[1]) + startHour; //開始時刻を分のみで表した
    List<String> endTimeList = _endTime.split(":");
    int endHour = int.parse(endTimeList[0]) * 60;
    int endTimeMinutes = int.parse(endTimeList[1]) + endHour;//終了時刻を分のみで表した
    double _left = clearArea.length*10;
    for (int i = 0; i < clearArea.length; i++){
      for (int j = 0; j < clearArea[i].length; j++){
        if (clearArea[i][j]["startTime"]! - 1 <= startTimeMinutes){
          if (clearArea[i][j]["endTime"]! >= endTimeMinutes){
            //_left = (i) * 10;
            _left = _timeLineWidth - (_timeLineWidth / (i+1)); //半分
            return _left;
          }
        }
      }
    }
    return _left;
  }

  //アクションの合計時間を計算する
  int calcTotalTime(String _startTime,String _endTime) {
    List<String> startTimeList = _startTime.split(":");
    List<String> endTimeList = _endTime.split(":");
    int startTimeConvMinutes = (int.parse(startTimeList[0]) * 60) + int.parse(startTimeList[1]);
    int endTimeConvMinutes = (int.parse(endTimeList[0]) * 60) + int.parse(endTimeList[1]);
    int _totalTime = endTimeConvMinutes - startTimeConvMinutes;
    
    return _totalTime;
  }
}