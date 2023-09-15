import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TimeLineCalender extends StatefulWidget {
  TimeLineCalender({required this.calenderWidth,required this.calenderHeight,required this.weekHeight,});
  //bodyのサイズを受け取る
  final double calenderWidth;
  final double calenderHeight;
  final double weekHeight;

  @override
  _TimeLineCalender createState() => _TimeLineCalender();
}

class _TimeLineCalender extends State<TimeLineCalender> {
  bool showButtons = false;
  int selectedMonth = DateTime.now().month; // 現在の月を初期値として設定
  int selectedYear = DateTime.now().year; // 現在の年を初期値として設定
  DateTime _focusedDay = DateTime.now();// 現在の日付を初期値として設定
  DateTime? _selectedDay;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  CalendarFormat _weekFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.calenderWidth,
      height: widget.calenderHeight,
      child:Stack(
      alignment: Alignment.topCenter,
      children: [
        // 呼び出すウィジェットを切り替え
        showButtons ? buildTableCalendar() : buildMonthSwitchButton(),
        //buildWeekCalendar()
      ]
      )
    );
  }
  
  // 月ボタンを表示するためのウィジェット
  Widget buildMonthSwitchButton() {

    return Container(
      child:Column(
        children: [
          ElevatedButton(style: ElevatedButton.styleFrom(
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
          ),
          buildWeekCalendar()
        ],
      )
      
      
    );
  }

  // カレンダーを表示するためのウィジェット
  Widget buildTableCalendar() {
    return Container(
      color: Colors.amber,
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2050, 12, 31),
        calendarFormat: _calendarFormat,
        daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(fontSize: 14),//平日のフォント
          weekendStyle: TextStyle(fontSize: 14),//週末のフォント
	      ),
	      daysOfWeekHeight: 20,//曜日の高さ
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,//week切り替えボタンの不可視
        ),
        locale: 'ja_JP',//日本語化
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
        
         onFormatChanged: (format) {
          if (_calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        
        focusedDay: _focusedDay,
      ),
    );
  }

  // 一週間表示を表示するためのウィジェット
  Widget buildWeekCalendar() {
    return Container(
      color: Colors.amber,
      height: widget.weekHeight,
      child: TableCalendar(
        headerVisible: false,//年数等ヘッダーの不可視
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2050, 12, 31),
        calendarFormat: _weekFormat,
        daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(fontSize: 14),//平日のフォント
          weekendStyle: TextStyle(fontSize: 14),//週末のフォント
	      ),
	      daysOfWeekHeight: 20,//曜日の高さ
        //headerStyle: HeaderStyle(
          //titleCentered: false,
          //formatButtonVisible: false,
        //),
        locale: 'ja_JP',//日本語化
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
          //showButtons = false;
        },
        
         onFormatChanged: (format) {
          if (_weekFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _weekFormat = format;
            });
          }
        },
        
        focusedDay: _focusedDay,
      ),
    );
  }
}
