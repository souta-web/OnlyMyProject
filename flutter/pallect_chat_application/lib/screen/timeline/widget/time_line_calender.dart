import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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
  int selectedYear = DateTime.now().year; // 現在の年を初期値として設定
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
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2050, 12, 31),
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