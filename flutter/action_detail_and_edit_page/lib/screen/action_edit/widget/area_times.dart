import 'package:action_detail_and_edit_page/screen/action_edit/widget/field_datas.dart';
import 'package:flutter/material.dart';
import '/widget/create_horizontal_line.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TimeArea extends StatefulWidget {
  final double deviceWidth;
  final FieldDatas fieldDatas;

  TimeArea({required this.deviceWidth,required this.fieldDatas});

  @override
  _TimeArea createState() => _TimeArea();
}

class _TimeArea extends State<TimeArea> {
  final double _thisHeight = 70.0;
  //static const Color _hintTextColor = Colors.red;
  static const double _thisTextFieldMargin = 5.0;
  DateTime _date = DateTime.now();
  final TextStyle fontData = TextStyle(fontSize: 24);
  late bool startTimeIsSelecting = false;
  late bool endTimeIsSelecting = false;
  late String registeredStartTime;
  late String registeredEndTime;
  
  void initState() {
    super.initState();
    // 初期化の処理をここに記述する
    registeredStartTime = widget.fieldDatas.startTime;
    registeredEndTime = widget.fieldDatas.endTime;
  }
    

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.deviceWidth,
      height: _thisHeight,
      child:Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal:_thisTextFieldMargin), //ウィジェットの外側の余白
            child:SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:Row(
                children: [
                  TextButton(
                    onPressed: () {
                      // ボタンが押されたときの処理を記述します
                      callCalender(true);
                    },
                    child: Text(registeredStartTime),
                    style: TextButton.styleFrom(
                      textStyle: fontData
                    ),
                  ),
                  Text(
                    "→",
                    style: fontData,
                  ),
                  TextButton(
                    onPressed: () {
                      // ボタンが押されたときの処理を記述します
                    },
                    child: Text(registeredEndTime),
                    style: TextButton.styleFrom(
                      textStyle: fontData
                    ),
                  ),
                ],
              )
            )
          ),
          HorizontalLine(),

        ],
      )
    );
  }

  //カレンダー表示
  void callCalender(bool isStartTime) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: new DateTime(2018),
      lastDate: new DateTime.now().add(new Duration(days: 360))
    );

    if (picked != null) {
      // 日時反映
      setState((){
        _date = picked;
        registeredStartTime = _date.toString();
      });
    }
  }

  //データベースに登録されている時間情報を表示用に整形する
  String timeDataConvertDisplayText() {

    return "";
  }
}