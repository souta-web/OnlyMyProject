import 'package:flutter/material.dart';
import 'widget/time_line_base.dart';
import 'package:table_calendar/table_calendar.dart';

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
        final double _topBarHeight = _bodyHeight/11;
        final double _calenderHeight = 340;//カレンダーサイズ 340未満だと警戒表示される
        late double _timeLineHeight = _bodyHeight - _topBarHeight;
        return Stack(
          children:[ 
            Expanded(
              child:SingleChildScrollView(
                child:Column(
                  children: [
                    SizedBox(height:_topBarHeight),//TimeLineTopBar分下に下げる
                    TimeLineBase(bodyWidth: _bodyWidth,bodyHeight: _timeLineHeight),
                  ],
                )
                
              )
            ),
            TimeLineTopBar(topBarWidth:_bodyWidth,topBarHeight:_topBarHeight),
            TimeLineCalender(calenderWidth:_bodyWidth,calenderHeight:_calenderHeight),
          ]
        );
      },
    );
  }
}

class TimeLineTopBar extends StatefulWidget {
  TimeLineTopBar({required this.topBarWidth,required this.topBarHeight});
  //bodyのサイズを受け取る
  final double topBarWidth;
  final double topBarHeight;

  @override
  _TimeLineTopBar createState() => _TimeLineTopBar();
}

class _TimeLineTopBar extends State<TimeLineTopBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: widget.topBarWidth,
      height: widget.topBarHeight,
      child:Stack(
      alignment: Alignment.topCenter,
      children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    print('Search button pressed!');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    print('Add button pressed!');
                  },
                ),
              ],
            ),
      ]
      )
    );
  }
}

class TimeLineCalender extends StatefulWidget {
  TimeLineCalender({required this.calenderWidth,required this.calenderHeight});
  //bodyのサイズを受け取る
  final double calenderWidth;
  final double calenderHeight;

  @override
  _TimeLineCalender createState() => _TimeLineCalender();
}

class _TimeLineCalender extends State<TimeLineCalender> {
  bool showButtons = false;
  int selectedMonth = DateTime.now().month; // 現在の月を初期値として設定
  DateTime _focusedDay = DateTime.now();// 現在の日付を初期値として設定
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.calenderWidth,
      height: widget.calenderHeight,
      child:Stack(
      alignment: Alignment.topCenter,
      children: [
        // 呼び出すウィジェットを切り替え
        showButtons ? buildTableCalendar() : buildSingleButton(),
      ]
      )
    );
  }
  
  // ボタンを表示するためのウィジェット
  Widget buildSingleButton() {

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Color.fromARGB(255, 255, 81, 0)),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      child: Text('$selectedMonth月'),
      onPressed: () {
        setState(() {
          showButtons = true;
        });
      },
    );
  }

  // カレンダーを表示するためのウィジェット
  Widget buildTableCalendar() {
    return Container(
      color: Colors.amber,
      child: TableCalendar(
        firstDay: DateTime.utc(2023, 1, 1),
        lastDay: DateTime.utc(2024, 12, 31),
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selected, focused) {
          if (!isSameDay(_selectedDay, selected)) {
            setState(() {
              _selectedDay = selected;
              _focusedDay = focused;

              selectedMonth = selected.month;
            });
          }
          showButtons = false;
        },
        focusedDay: _focusedDay,
      ),
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