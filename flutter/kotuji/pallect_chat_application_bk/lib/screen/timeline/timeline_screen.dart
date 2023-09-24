import 'package:flutter/material.dart';
import 'widget/time_line_base.dart';
import 'widget/time_line_topbar.dart';
import 'widget/time_line_calender.dart';

class TimelineScreenWidget extends StatefulWidget {

  @override
  _TimelineScreenWidgetState createState() => _TimelineScreenWidgetState();
}

class _TimelineScreenWidgetState extends State<TimelineScreenWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timeline'),
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
      body:TimeLineBody(),
      floatingActionButton: WidgetFloatingActionButton(),
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
        //var instance = _TimeLineCalender();
        DateTime _toDay = DateTime.now();// 現在の日付を初期値として設定;
        //String formattedDate = setSchedule(_toDay);
        final _newData = [{"startTime": "0:00","endTime": "1:00" ,"color": Colors.amber,"title": "default"},
                          {"startTime": "1:00","endTime": "2:00" ,"color": Colors.amber,"title": "default"},];
        final double _topBarHeight = _bodyHeight/8;
        final double _weeekCalenderHeight = 72;//週のカレンダーサイズ
        final double _calenderHeight = 340+56;//カレンダーサイズ 340未満だと警戒表示される
        late double _timeLineHeight = _bodyHeight - _topBarHeight;
        return Stack(
          children:[ 
            Expanded(
              child:SingleChildScrollView(
                child:Column(
                  children: [
                    SizedBox(height:_topBarHeight+(_topBarHeight-_weeekCalenderHeight)+10),//TimeLineTopBarと一週間表示分下に下げる（重なっている部分は省く）+00は調整用
                    TimeLineBase(bodyWidth: _bodyWidth,bodyHeight: _timeLineHeight,newData:_newData),
                  ],
                )
                
              )
            ),
            TimeLineTopBar(topBarWidth:_bodyWidth,topBarHeight:_topBarHeight),
            TimeLineCalender(calenderWidth:_bodyWidth,calenderHeight:_calenderHeight,weekHeight:_weeekCalenderHeight),
          ]
        );
      },
    );
  }
}

//右下のボタン作成
class WidgetFloatingActionButton extends StatefulWidget {

  @override
  _WidgetFloatingActionButton createState() => _WidgetFloatingActionButton();
}

class _WidgetFloatingActionButton extends State<WidgetFloatingActionButton> {

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // ボタンが押されたときの処理を記述
        setState(() {
          print("tap");
        });
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.blue, // FABの背景色を変更
    );
  }
}