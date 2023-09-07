import 'package:flutter/material.dart';
import 'widget/time_line_base.dart';
import 'package:table_calendar/table_calendar.dart';

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
        final double _topBarHeight = 340;//_bodyHeight/10;
        late double _timeLineHeight = _bodyHeight - _topBarHeight;
        return Stack(
          children:[
            Expanded(
              child:SingleChildScrollView(
                child:Column(
                  children: [
                    SizedBox(height:_topBarHeight),
                    TimeLineBase(bodyWidth: _bodyWidth,bodyHeight: _timeLineHeight)
                  ],
                )
              )
            ),
            Expanded(
               child:TimeLineTopBar(topBarWidth:_bodyWidth,topBarHeight:_topBarHeight),
            )
           
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
  bool showButtons = false;
  int selectedMonth = DateTime.now().month; // 現在の月を初期値として設定
  DateTime _focusedDay = DateTime.now();// 現在の日付を初期値として設定
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.topBarWidth,
      height: widget.topBarHeight,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
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
          ),
          // 呼び出すウィジェットを切り替え
          showButtons ? buildTableCalendar() : buildSingleButton(),
        ]
      ),
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
    return Expanded(
      child: Container(
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