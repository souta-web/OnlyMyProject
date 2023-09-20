import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../func/action_registration_base.dart';
import 'time_line_base.dart';
//import '../../setting/config_screen.dart';
//import 'package:intl/intl.dart';//カレンダーのタイトルを月の形式にカスタマイズするのに必要


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
  int previousSelectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year; // 現在の年を初期値として設定
  
  DateTime _focusedDay = DateTime.now();// 現在の日付を初期値として設定
  DateTime _selectedDay = DateTime.now();// 現在の日付を初期値として設定;

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
              side: BorderSide(color: Color(0xFFFF9515)),
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
      color: Colors.white,
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2050, 12, 31),
        calendarFormat: _calendarFormat,
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: Color(0xFFFF9515), // 選択された日付の背景色をここで指定
            shape: BoxShape.circle, // 選択された日付を丸くする場合は必要
          ),
        ),
        daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(fontSize: 14),//平日のフォント
          weekendStyle: TextStyle(fontSize: 14),//週末のフォント
	      ),
	      daysOfWeekHeight: 20,//曜日の高さ
        availableGestures: AvailableGestures.horizontalSwipe, // 横方向のスワイプのみを有効にする
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,//week切り替えボタンの不可視
          // カレンダーのタイトルを月の形式にカスタマイズ
          //titleTextFormatter: (date, locale) {
          //return '${DateFormat.MMMM(locale).format(date)}';
        //},
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
      color: Colors.white,

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
        availableGestures: AvailableGestures.horizontalSwipe, // 横方向のスワイプのみを有効にする
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: Color(0xFFFF9515), // 選択された日付の背景色をここで指定
            shape: BoxShape.circle, // 選択された日付を丸くする場合は必要
          ),
        ),
        headerStyle: HeaderStyle(
          //titleCentered: false,
          //formatButtonVisible: false,
          
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
              previousSelectedMonth = selectedMonth;

              String formattedDate = setSchedule(_selectedDay);
              print(formattedDate);

              List<Map<String, dynamic>> settingDate = setData(formattedDate);
              //print(formattedDate);
              //print(_selectedDay);
              print(settingDate);

              //upDateData(settingDate);
              
            });
          }
        },
        
         onFormatChanged: (format) {// フォーマット変更に成功した際の処理
          if (_weekFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _weekFormat = format;
            });
          }
        },

        onPageChanged: (focusedDay) {
          //final nextWeek = focusedDay.add(Duration(days: 7));
          //focusedDay = nextWeek;
          _focusedDay = focusedDay;
          selectedMonth = focusedDay.month;
          if (selectedMonth != previousSelectedMonth) {
            // selectedMonth が変更された場合の処理をここに追加
            // previousSelectedMonth は前回の selectedMonth の値を示す変数です
            print("change");
            previousSelectedMonth = selectedMonth; // 変更前の値を更新
            setState(() {
              selectedMonth = focusedDay.month;
            });
          }
          print(focusedDay);
          print(_selectedDay);
        },
        focusedDay: _focusedDay,
      ),
    );
  }

  String setSchedule(DateTime _selectedDay) {
    // 年、月、日を取得
    int year = _selectedDay.year;
    int month = _selectedDay.month;
    int day = _selectedDay.day;

    // 各要素を2桁の文字列に変換
    String yearStr = year.toString();
    String monthStr = month.toString().padLeft(2, '0');
    String dayStr = day.toString().padLeft(2, '0');

    // "yYYYYmMMdDD" の形式に結合して返す
    String formattedDate = 'y$yearStr' + 'm$monthStr' + 'd$dayStr';
    
    return formattedDate;
  }
}
