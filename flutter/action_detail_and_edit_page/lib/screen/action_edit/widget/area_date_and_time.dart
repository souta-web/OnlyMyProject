import 'package:action_detail_and_edit_page/screen/action_edit/widget/field_datas.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter/material.dart';
import '/widget/create_horizontal_line.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

//時間と日付用の編集エリア
class DateAndTimeArea extends StatefulWidget {
  final double deviceWidth;
  final FieldDatas fieldDatas;

  DateAndTimeArea({required this.deviceWidth,required this.fieldDatas});

  @override
  _DateAndTimeArea createState() => _DateAndTimeArea();
}

class _DateAndTimeArea extends State<DateAndTimeArea> {
  final double _thisHeight = 170.0;
  //static const Color _hintTextColor = Colors.red;
  static const double _thisTextFieldMargin = 5.0;
  DateTime _date = DateTime.now();
  final TextStyle fontData = TextStyle(fontSize: 24);
  late bool startTimeIsSelecting = false;
  late bool endTimeIsSelecting = false;
  late String registeredStartDateTime;
  late String registeredEndDateTime;
  late String displayStartDate;
  late String displayStartTime;
  late String displayEndDate;
  late String displayEndTime;

  void initState() {
    super.initState();
    // 初期化の処理をここに記述する
    registeredStartDateTime = widget.fieldDatas.startTime;
    registeredEndDateTime = widget.fieldDatas.endTime;
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
                  Column(//スタートの時間を作成
                    children: [
                      TextButton(
                        onPressed: () {
                          // ボタンが押されたときの処理を記述します
                          callCalender(true);
                        },
                        child: Text(timeDataConvertDisplayText(text:registeredStartDateTime,isDate: true)),
                        style: TextButton.styleFrom(
                          textStyle: fontData
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          
                        },
                        child: Text(timeDataConvertDisplayText(text:registeredStartDateTime,isDate: false)),
                        style: TextButton.styleFrom(
                          textStyle: fontData
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "→",
                    style: fontData,
                  ),
                  TextButton(
                    onPressed: () {
                      // ボタンが押されたときの処理を記述します
                    },
                    child: Text(registeredEndDateTime),
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
        registeredStartDateTime = _date.toString();
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
  }

  //DateTime形式の時間情報を表示用に整形する 
  String timeDataConvertDisplayText({required String text,required bool isDate}) {
    List<String> textList = text.split(" ");
    String returnText = "";
    
    if(isDate) {
      textList = textList[0].toString().split("-");
      returnText = textList[1].toString() + "月" + textList[2] + "日";
      return returnText;
    }else{
      textList = textList[1].toString().split(":");
      returnText = textList[0].toString() + "時" + textList[1] + "分";
      return returnText;
    }
  }
}