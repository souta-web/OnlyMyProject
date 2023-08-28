import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'dart:math'; // ランダムな数値を生成するために必要

class TimelineScreenWidget extends StatefulWidget {
  @override
  _TimelineScreenWidgetState createState() => _TimelineScreenWidgetState();
}

class _TimelineScreenWidgetState extends State<TimelineScreenWidget> {
  bool showButtons = false;
  int selectedMonth = DateTime.now().month; // 現在の月を初期値として設定
  DateTime _focusedDay = DateTime.now();// 現在の日付を初期値として設定
  DateTime? _selectedDay;

  List<Widget> addedButtons = []; // 新しいボタンのリスト

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('タイムライン'),
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
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
                      // 24時間表示を呼び出し
                      buildHourRows(),
                      
                    ],
                  ),
                  ...addedButtons, // 新しいボタンのリストを表示
                   // 呼び出すウィジェットを切り替え
                  showButtons ? buildTableCalendar() : buildSingleButton(),
                  
                ],
                
              ),
            ),
          ),
        ],
      ),
      // 画面右下にFAB（Floating Action Button）を追加
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ボタンが押されたときの処理を記述
          setState(() {
              print("tap");
              addedButtons.add(buildActionButton());
            });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue, // FABの背景色を変更
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

    return Container(
      color: Colors.white,
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

// 24時間を表示するためのウィジェット
  Widget buildHourRows() {
    
    return Column(
      children: [
        for (var i = 0; i < 25; i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  '$i:00',
                  textAlign: TextAlign.right,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                color: Color.fromARGB(255, 104, 104, 104),
                width: 300.0,
                height: 2.0,
              ),
              SizedBox(height: 40.0),
              SizedBox(width: 30.0),
            ],
          ),
      ],
    );
  }

//fabを押した際に追加されるボタン
  Widget buildActionButton() {
  final random = Random(); // ランダムな数値を生成するためのインスタンス

  double randomPosition = random.nextDouble() * 700 + 70; // 20から120の範囲のランダムな数値を生成
  double randomHeight = random.nextDouble() * 400 + 20; // 20から120の範囲のランダムな数値を生成
  return Column(
    children: [
      SizedBox(height: randomPosition),
      Container(
        width: 250.0, // ボタンの幅を設定
        height: randomHeight, // ランダムな高さを設定
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              //side: BorderSide(color: Color.fromARGB(255, 255, 81, 0)),
            ),
            backgroundColor: Color.fromARGB(255, 255, 0, 255).withOpacity(0.9), // 半透明な白色
            foregroundColor: Colors.black,
          ),
          child: Text('aaa'),
          onPressed: () {
            setState(() {
              print("tap");
            });
          },
        ),
      ),
    ],
  );
}


}